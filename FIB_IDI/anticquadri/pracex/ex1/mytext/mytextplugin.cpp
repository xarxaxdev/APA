#include "mytext.h"
#include "mytextplugin.h"

#include <QtPlugin>

mytextPlugin::mytextPlugin(QObject *parent)
    : QObject(parent)
{
    m_initialized = false;
}

void mytextPlugin::initialize(QDesignerFormEditorInterface * /* core */)
{
    if (m_initialized)
        return;

    // Add extension registrations, etc. here

    m_initialized = true;
}

bool mytextPlugin::isInitialized() const
{
    return m_initialized;
}

QWidget *mytextPlugin::createWidget(QWidget *parent)
{
    return new mytext(parent);
}

QString mytextPlugin::name() const
{
    return QLatin1String("mytext");
}

QString mytextPlugin::group() const
{
    return QLatin1String("");
}

QIcon mytextPlugin::icon() const
{
    return QIcon();
}

QString mytextPlugin::toolTip() const
{
    return QLatin1String("");
}

QString mytextPlugin::whatsThis() const
{
    return QLatin1String("");
}

bool mytextPlugin::isContainer() const
{
    return false;
}

QString mytextPlugin::domXml() const
{
    return QLatin1String("<widget class=\"mytext\" name=\"mytext\">\n</widget>\n");
}

QString mytextPlugin::includeFile() const
{
    return QLatin1String("mytext.h");
}
#if QT_VERSION < 0x050000
Q_EXPORT_PLUGIN2(mytextplugin, mytextPlugin)
#endif // QT_VERSION < 0x050000
