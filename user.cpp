#include "user.h"
#include <QString>
#include <QChar>
User::User(QObject *parent)
    : QObject{parent}
{

}

User *User::getInstance()
{
    static User * us = new User();
    return us;
}

double User::a_amount()
{
    return this->amount;
}

QString User::u_username()
{
    return this->userName;
}

bool User::s_status()
{
    return this->status;
}

QChar User::t_type()
{
    return QChar::fromLatin1(this->type);
}

Message User::s_sendMessage()
{
    return this->sendMessage;
}

Message User::r_receiveMessage()
{
    return this->receiveMessage;
}

void User::set_receiveLoginMessage(Message m)
{
    this->receiveMessage = m;
    this->userName = QString::fromUtf8(m.info_name);
    this->status = m.status;
    this->amount = m.number;
    this->type = m.type;
    qDebug()<<m.type;
}

void User::set_receiveRegisterMessage(Message m)
{
    this->receiveMessage = m;
    this->status = m.status;
    this->type = m.type;
    qDebug()<<m.type;
}

void User::set_receiveMessage(Message m)
{
    this->receiveMessage = m;
    this->status = m.status;
    qDebug()<<"From the client,the number:"<<m.number;
    this->type = m.type;
    if(m.type != '5' && m.type != '6'){
        this->amount = m.number;
    }
}

void User::loginSlot(QString name,QString password)
{
    char *temp;
    temp = name.toLatin1().data();
    memcpy(this->sendMessage.info_name,temp,16);
    //free(temp);
    temp=NULL;
    qDebug()<<"username write OK";

    temp = password.toLatin1().data();
    memcpy(this->sendMessage.info_password,temp,16);
    //free(temp);
    temp=NULL;

    this->sendMessage.type='0';
}

void User::registerSlot(QString name, QString password)
{
    char *temp;
    temp = name.toLatin1().data();
    memcpy(this->sendMessage.info_name,temp,16);
    //free(temp);
    temp=NULL;
    qDebug()<<"username write OK";

    temp = password.toLatin1().data();
    memcpy(this->sendMessage.info_password,temp,16);
    //free(temp);
    temp=NULL;

    this->sendMessage.type='1';
    qDebug()<<"Ready to send register message";
}

void User::transferSlot(QString name, double money)
{
    char* temp;
    temp = name.toLatin1().data();
    memcpy(this->sendMessage.info_password,temp,16);
    //free(temp);
    temp=NULL;
    qDebug()<<"target name write OK";

    temp = this->u_username().toLatin1().data();
    memcpy(this->sendMessage.info_name,temp,16);
    temp=NULL;
    qDebug()<<"user name write OK";

    this->sendMessage.number = money;
    this->sendMessage.type='7';

}



void User::drawAndSaveSlot(double money)
{
    memcpy(this->sendMessage.info_name,this->userName.toLatin1().data(),16);
    this->sendMessage.number = money;
    qDebug()<<"drawAndSaveSlot:"<<money;
    this->sendMessage.type='3';
}

void User::checkSlot()
{
    memcpy(this->sendMessage.info_name,this->userName.toLatin1().data(),16);
    this->sendMessage.type='2';

}
