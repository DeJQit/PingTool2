#include "sprocess.h"

#include <QVariant>
#include <QtDebug>

#ifdef Q_OS_WIN32
#include <QTextCodec>
#endif

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
#ifdef Q_OS_WIN32
    QTextCodec *codec = QTextCodec::codecForName("Windows-1251");
    return codec->toUnicode(QProcess::readAllStandardOutput());
#else
    return QProcess::readAll();
#endif
}

QByteArray SProcess::readAllStandardOutput()
{
#ifdef Q_OS_WIN32
    QTextCodec *codec = QTextCodec::codecForName("Windows-1251");
    return codec->toUnicode(QProcess::readAllStandardOutput());
#else
    return QProcess::readAllStandardOutput();
#endif
}

QByteArray SProcess::readAllStandardError()
{
#ifdef Q_OS_WIN32
    QTextCodec *codec = QTextCodec::codecForName("Windows-1251");
    return codec->toUnicode(QProcess::readAllStandardOutput());
#else
    return QProcess::readAllStandardError();
#endif
}
