import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import QtQuick.Dialogs 1.3
import "./MyQmlObject"

Rectangle {
    width: parent.width
    height: parent.height

    MyMessageDialog {
        id: noLegalSaveAmountDialog
        text: "请输入合法金额（大于0）"
        onYes: close()
    }
    MyMessageDialog {
        id: successDialog
        text: "操作成功！"
        onYes:{
            close()
            myStackView.pop()
        }

    }

    Label{
        text:"您的当前余额为: "+user.a_amount().toString()
        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
    }

    Row{
        x:10
        y:100
        spacing:10

        Text{
            text:"您打算存款："
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:saveInput
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: RegExpValidator{regExp: /(\d{1,4})([.,]\d{1,2})?$/}
            }
        }
    }


    signal saveSig(double money)
    Button{
        x:20
        y:170
        text:qsTr("确认")

        style:MyButtonStyle{}

        onClicked:{
            if(Number(saveInput.text)===0){
                noLegalSaveAmountDialog.open()
            }
            else{
                saveSig(Number(saveInput.text))
                client.send(user.s_sendMessage())
                user.set_receiveMessage(client.receive())
                if(user.t_type() === '6'){
                    networkWrong.open();
                }
                else{
                    successDialog.open();
                }
            }
        }
    }


    Connections{
        target:savePage.item
        function onSaveSig(moneyAmount){
            user.drawAndSaveSlot(moneyAmount)
            console.log("Save success")
        }
    }

    Button{
        x:100
        y:170
        text:qsTr("取消")

        style:MyButtonStyle{}

        onClicked: myStackView.pop()
    }
}
