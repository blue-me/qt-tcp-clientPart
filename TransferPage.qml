import QtQuick 2.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import "./MyQmlObject"

Rectangle{
    width:parent.width
    height:parent.height
    property double amount:0

    MyMessageDialog{
        id:noEnoughAmountDialog
        text: "您的余额已不足"
        onYes: close()
    }

    MyMessageDialog {
        id: noLegalDrawAmountDialog
        text: "请输入合法金额（大于0）"
        onYes: close()
    }

    MyMessageDialog {
        id: accountNoExistDialog
        text: "帐号不存在"
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
            text:"汇款账号："
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:transferAccountInput
            }
        }
    }

    Row{
        x:10
        y:140
        spacing:10

        Text{
            text:"汇款金额："
            font.pointSize: 15
        }

        MyInputRectangle{
            MyTextInput{
                id:transferAmountInput
                inputMethodHints: Qt.ImhFormattedNumbersOnly
                validator: RegExpValidator{regExp: /(\d{1,4})([.,]\d{1,2})?$/}
            }
        }
    }

    signal transferSig(string targetName,double money)

    Button{
        id:transferSure
        x:100
        y:200
        text: qsTr("确定")

        style:MyButtonStyle{}

        onClicked:{
            amount = user.a_amount()
            if(Number(transferAmountInput.text)===0){
                noLegalDrawAmountDialog.open()
            }
            else if(Number(transferAmountInput.text) >= amount){
                noEnoughAmountDialog.open()
            }
            else{
                transferSig(transferAccountInput.text,Number(transferAmountInput.text))
                client.send(user.s_sendMessage())
                user.set_receiveMessage(client.receive())
                if(user.t_type() === '6'){
                    networkWrong.open();
                }
                else if(user.t_type() === '5'){
                    accountNoExistDialog.open()
                }
                else{
                    successDialog.open()
                }
            }
        }

    }

    Connections{
        target:transferPage.item
        function onTransferSig(userName,moneyAmount){
            user.transferSlot(userName,moneyAmount)
            console.log("Draw success")
        }
    }

    Button{
        id:transferCancel
        x:200
        y:200
        text: qsTr("取消")

        style:MyButtonStyle{}

        onClicked: myStackView.pop()
    }
}
