import QtQuick 2.0
import QtQuick.Dialogs 1.1

MessageDialog {
    id: messageDialogExample
    title: "提示"
    modality: Qt.WindowModal
    //text: "您的余额已不足"
    standardButtons: StandardButton.Yes
    visible: false
    //onYes: close()
}
