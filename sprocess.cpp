#include "sprocess.h"

#include <QVariant>
#include <QtDebug>

SProcess::SProcess(QObject *parent)
    : QProcess (parent)
{

}

void SProcess::start(const QString &program, const QVariantList &arguments)
{
    // Convert QML QVariantList to QStringList
    QStringList args;

    for(auto it = arguments.begin(); it != arguments.end(); it++) {
        args << it->toString();
    }

    QProcess::start(program, args);
}

QByteArray SProcess::readAll()
{
    return QProcess::readAll();
}

QByteArray SProcess::readAllStandardOutput()
{
    return QProcess::readAllStandardOutput();
}

QByteArray SProcess::readAllStandardError()
{
    return QProcess::readAllStandardError();
}
