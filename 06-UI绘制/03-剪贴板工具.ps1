<#
    案例来源: 【PowerShell】Windows標準機能でつくるクリップボード履歴ツール
        https://qiita.com/8_hisakichi_8/items/a023922217d339fba6db
#>

# 必要なアセンブリをロード
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# --- グローバル設定用の変数 ---
$FontName = "Meiryo UI" # 使用するフォント名を定義

# --- レイアウト定数 ---
$formWidth = 270 
$formHeight = 360 
$edgeMargin = 15 # フォームの端からのマージンを設定
$copyButtonWidth = 80 # コピーボタンの幅を定義
$copyButtonHeight = 30 # コピーボタンの高さを定義
$controlGroupTopMargin = 15 # コントロールグループ（ボタンなど）の上マージンを定義
$checkBoxWidth = 125 # チェックボックスの幅を定義
$checkBoxHeight = 20 # チェックボックスの高さを定義
$horizontalGapButtonToCheckBoxGroup = 20 # ボタンとチェックボックスグループ間の水平方向の間隔
$verticalGapCheckBox = 5 # チェックボックス間の垂直方向の間隔
 
# --- メインフォームの作成とプロパティ設定 ---
$mainForm = [System.Windows.Forms.Form]@{
    Text = "クリップボード履歴ツール" # ウィンドウのタイトルを設定
    Width = $formWidth              # ウィンドウの幅を設定
    Height = $formHeight            # ウィンドウの高さを設定
    StartPosition = "CenterScreen"  # フォームを画面中央に表示
    FormBorderStyle = "FixedSingle" # フォームの枠を固定し、サイズ変更を不可にする
    MaximizeBox = $false            # 最大化ボタンを無効にする
    TopMost = $true                 # 最前面表示に固定
}

# フォームのインスタンスが作成された直後にClientSizeを取得
# これがコントロール配置の基準となるクライアント領域のサイズ
$actualClientWidth = $mainForm.ClientSize.Width

# --- データグリッドの作成とプロパティ設定 ---
$dataGridView = [System.Windows.Forms.DataGridView]@{
    ColumnCount = 1                                   # 列数を1に設定
    Font = [System.Drawing.Font]::new($FontName, 8)   # データグリッドのフォントを設定
    RowHeadersVisible = $false                        # 行ヘッダー（左側の行番号）を非表示にする
    Width = $actualClientWidth - $edgeMargin * 2      # クライアント領域の幅から左右のマージンを引いた幅
    Left = $edgeMargin                                # フォームの左端から指定マージン離して配置
    Top = $edgeMargin                                 # フォームの上端から指定マージン離して配置
    Height = 230                                      # データグリッドの高さを固定
}

# データグリッドの列ヘッダーを設定
$dataGridView.Columns[0].Name = "クリップボード履歴" # 1列目の列名を「クリップボード履歴」に設定
$dataGridView.Columns[0].AutoSizeMode = [System.Windows.Forms.DataGridViewAutoSizeColumnMode]::Fill # 列幅をデータグリッドの幅に合わせて自動調整

# --- 「Copy」ボタンの作成 ---
$copyButton = [System.Windows.Forms.Button]@{
    Text = "Copy"                 # ボタンに表示するテキスト
    Font = [System.Drawing.Font]::new($FontName, 9) # ボタンのフォントを設定
    Width = $copyButtonWidth      # ボタンの幅を設定
    Height = $copyButtonHeight    # ボタンの高さを設定
    Left = $edgeMargin            # フォームの左端からマージン分配置
    Top = $dataGridView.Bottom + $controlGroupTopMargin # データグリッドの最下部から指定マージン下に配置
}

# --- 最前面固定チェックボックスの作成 ---
$alwaysOnTopCheckBox = [System.Windows.Forms.CheckBox]@{
    Text = "最前面に固定"          # チェックボックスのテキスト
    Font = [System.Drawing.Font]::new($FontName, 8) # フォント設定
    Width = $checkBoxWidth         # 幅
    Height = $checkBoxHeight       # 高さ
    Checked = $true                # 初期状態でチェックを入れておく
    Left = $copyButton.Right + $horizontalGapButtonToCheckBoxGroup # Copyボタンの右に水平方向のマージンを開けて配置
    Top = $copyButton.Top          # Copyボタンと垂直方向の位置を揃える
}

# --- 非アクティブ時半透明チェックボックスの作成 ---
$transparencyCheckBox = [System.Windows.Forms.CheckBox]@{
    Text = "非アクティブ時に半透明" # チェックボックスのテキスト
    Font = [System.Drawing.Font]::new($FontName, 8) # フォント設定
    Width = $checkBoxWidth         # 幅
    Height = $checkBoxHeight       # 高さ
    Checked = $true                # 初期状態でチェックを入れておく
    Left = $alwaysOnTopCheckBox.Left # 最前面固定チェックボックスと同じ水平位置に配置
    Top = $alwaysOnTopCheckBox.Bottom + $verticalGapCheckBox # 最前面固定チェックボックスの直下に配置
}

# --- コントロールをメインフォームに追加 ---
$mainForm.Controls.Add($dataGridView) # 作成したデータグリッドをフォームに追加
$mainForm.Controls.Add($copyButton) # 作成したCopyボタンをフォームに追加
$mainForm.Controls.Add($alwaysOnTopCheckBox) # 作成した最前面固定チェックボックスをフォームに追加
$mainForm.Controls.Add($transparencyCheckBox) # 作成した非アクティブ時半透明チェックボックスをフォームに追加
 
# --- クリップボード監視機能の準備（タイマーポーリング方式） ---
$script:LastClipboardContent = "" # 前回のクリップボード内容を保持するグローバル変数
$clipboardMonitorTimer = [System.Windows.Forms.Timer]::new() # タイマーのインスタンスを作成
$clipboardMonitorTimer.Interval = 2000 # 2000ミリ秒 (2秒) ごとにチェックを実行
$clipboardMonitorTimer.Enabled = $false # 初期状態ではタイマーを無効にしておく

$script:Timer_Tick = {
    # 現在のクリップボード内容を取得
    $currentClipboardContent = [System.Windows.Forms.Clipboard]::GetText()

    # 前回の内容と比較し、異なっていれば履歴としてデータグリッドに追加
    if ($currentClipboardContent -ne $script:LastClipboardContent) {
        $script:LastClipboardContent = $currentClipboardContent # 新しい内容をLastClipboardContentに記録
        $dataGridView.Rows.Add($currentClipboardContent) # データグリッドに行を追加
        
        # データグリッドのスクロール位置を調整し、最新の履歴が見えるようにする
        if ($dataGridView.Rows.Count -gt 0) {
            $dataGridView.FirstDisplayedScrollingRowIndex = $dataGridView.Rows.Count - 1
        }
    }
}
$clipboardMonitorTimer.add_Tick($script:Timer_Tick) # タイマーのTickイベントにスクリプトブロックを登録
 
# --- 「Copy」ボタンのクリックイベントハンドラの定義 ---
$script:CopyButton_Click = {
    if ($dataGridView.SelectedCells.Count -gt 0) {

       # 選択されたセルを行番号でソート
       $sortedCells = $dataGridView.SelectedCells | Sort-Object { $_.RowIndex }
       # 選択されたテキストを格納する配列
       $selectedTexts = @()

       # ソート後のセルをループ処理し、そのテキスト値を取得
       foreach ($cell in $sortedCells) {
            if ($cell.Value -ne $null) {
                $selectedTexts += $cell.Value.ToString()  # セルの値があれば文字列として配列に追加
            } else {
                $selectedTexts += "" # セルが空の場合は空文字列を追加
            }
        }

        # 有効な文字列が１つでもあればクリップボード出力処理
        if ($selectedTexts.Count -gt 0) {
            # クリップボードへのコピー前に、比較用変数に代入
            # (コピーボタン押下時にデータグリッドへの出力を防ぐため)
            $script:LastClipboardContent = $concatedText
            # 配列を結合し、クリップボードにコピー
            $concatedText = $selectedTexts -join "`r`n"  # 結合処理
            Set-Clipboard -Value $concatedText  # クリップボードへコピー
        }
    } 
}
$copyButton.add_Click($script:CopyButton_Click)
 
# --- 最前面固定チェックボックスのイベントハンドラ ---
$script:AlwaysOnTopCheckBox_CheckedChanged = {
    # チェックボックスの状態に応じてフォームのTopMostプロパティ（最前面表示）を設定
    $mainForm.TopMost = $alwaysOnTopCheckBox.Checked
}
$alwaysOnTopCheckBox.add_CheckedChanged($script:AlwaysOnTopCheckBox_CheckedChanged) # CheckedChangedイベントにスクリプトブロックを登録

# --- フォームのアクティブ/非アクティブイベントハンドラ (半透明機能用) ---
$script:MainForm_Activated = {
    # フォームがアクティブになったら常に不透明（Opacity 1.0）に戻す
    $mainForm.Opacity = 1.0
}
$mainForm.add_Activated($script:MainForm_Activated) # Activatedイベントにスクリプトブロックを登録

$script:MainForm_Deactivate = {
    # 半透明チェックボックスがオンの場合のみ、フォーム非アクティブ時に半透明（Opacity 0.7）にする
    if ($transparencyCheckBox.Checked) {
        $mainForm.Opacity = 0.7
    }
}
$mainForm.add_Deactivate($script:MainForm_Deactivate) # Deactivateイベントにスクリプトブロックを登録

# メインフォームがロードされたときにタイマーを開始
$mainForm.add_Load({
    Set-Clipboard  # クリップボードを初期化
    $clipboardMonitorTimer.Start()
})

# メインフォームが閉じられるときにタイマーを停止・解放
$mainForm.add_FormClosed({
    $clipboardMonitorTimer.Stop()
    $clipboardMonitorTimer.Dispose()
})

# --- フォーム表示 ---
$null = $mainForm.ShowDialog()

# --- フォームが閉じられた後の後処理 ---
$mainForm.Dispose()