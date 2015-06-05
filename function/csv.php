<?php

/**
 * Class csv
 *
 * CSVの操作に関係する機能テンプレート
 */
class csv
{
    /**
     * POSTされたCSVファイルをサーバに保存
     *
     * @return bool
     */
    public function csvFileInput()
    {
        // 選択されたファイル情報を取得する
        $tmp_file_name = $_FILES['csvfile']['tmp_name'];
        $file_name = $_FILES['csvfile']['name'];

        // エラー処理
        if (empty($tmp_file_name)) {
            return false;
        }

        // CSVファイルかどうか、拡張子チェック
        if (pathinfo($file_name, PATHINFO_EXTENSION) != 'csv') {
            return false;
        }

        // 文字コード関係をセット ※Excelファイルでも読めるように
        $detect_order = 'ASCII,JIS,UTF-8,CP51932,SJIS-win';
        setlocale(LC_ALL, 'ja_JP.UTF-8');

        // 文字エンコードチェック
        $buffer = file_get_contents($tmp_file_name);
        $encoding = mb_detect_encoding($buffer, $detect_order, true);
        if (!$encoding) {
            unset($buffer);
            return false;
        }

        // 文字コード変換
        file_put_contents($tmp_file_name, mb_convert_encoding($buffer, 'UTF-8', $encoding));
        unset($buffer);

        try {

            // 配列に変換
            $fp = fopen($tmp_file_name, 'rb');
            while (($data = fgetcsv($fp, 0, ",")) !== false) {
                $arr_csv_data[] = $data;
            }
            fclose($fp);

            // 保存先のサーバディレクトリ設定 todo: 環境に合わせて変更
            $save_dir = '/';

            // 保存するCSVファイル名 todo: 環境に合わせて変更
            $save_file_name = date('Ymd_His') . '.csv';

            // 保存パス
            $save_path = $save_dir . $save_file_name;

            // CSVファイルをサーバに保存
            move_uploaded_file($tmp_file_name, $save_path);

        } catch (Exception $e) {

            // エラー処理
            fclose($fp);
            return false;
        }
    }

    /**
     * サーバ上にあるCSVファイルを読込、配列にして返す
     *
     * @return array|bool
     */
    public function makeCsvArray()
    {
        // 保存先のサーバディレクトリ設定 todo: 環境に合わせて変更
        $save_dir = '/';

        // 保存するCSVファイル名 todo: 環境に合わせて変更
        $csv_file = date('Ymd_His') . '.csv';

        // 保存パス
        $save_path = $save_dir . $csv_file;

        $arr_csv_data = array();
        try {

            // CSVファイルを取得し、配列へ変換
            $fp = fopen($save_path, 'rb');
            while (($data = fgetcsv($fp, 0, ",")) !== false) {
                $arr_csv_data[] = $data;
            }
            fclose($fp);

        } catch (Exception $e) {
            fclose($fp);
            return false;
        }

        return $arr_csv_data;
    }
}