import QtQuick 2.15
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.15
import "./MyQmlObject"

Rectangle {
    width: parent.width
    height: parent.height
    property double remainAmount:0

    MyMessageDialog {
        id: noEnoughAmountDialog
        text: "您的余额已不足"
        onYes: close()
    }

    MyMessageDialog {
        id: noLegalDrawAmountDialog
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
            text:"您打算取款："
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:drawInput
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: RegExpValidator{regExp: /(\d{1,4})([.,]\d{1,2})?$/}
            }
        }
    }

    signal drawSig(double money)
    Button{
        x:20
        y:170
        text:qsTr("确认")

        style:MyButtonStyle{}

        onClicked:{
            remainAmount = user.a_amount()
            if(Number(drawInput.text) === 0){
                noLegalDrawAmountDialog.open()
            }
            else if(remainAmount >= Number(drawInput.text)){
                drawSig(Number(drawInput.text))
                client.send(user.s_sendMessage())
                user.set_receiveMessage(client.receive())
                if(user.t_type() === '6'){
                    networkWrong.open();
                }
                else{
                    successDialog.open()
                }
            }
            else{
                noEnoughAmountDialog.open()
            }
        }
    }

    Connections{
        target:drawPage.item
        function onDrawSig(moneyAmount){
            user.drawAndSaveSlot(moneyAmount * (-1))
            console.log("Draw success")
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
