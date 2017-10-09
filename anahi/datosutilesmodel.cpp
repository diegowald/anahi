#include "datosutilesmodel.h"

DatosUtilesModel::DatosUtilesModel(QObject *parent ) : QAbstractListModel(parent)
{
/*    QString fullName;
*/
    m_datoUtil.append( { "Loft Rental", "Brandsen 456", "Bahia Blanca", "http://maps.google.com/maps?daddr=-38.7193941,-62.2544412", "Alojamiento Entrenadores", DatoUtilType::Map });
    m_datoUtil.append( { "Andrea", "", "Bahia Blanca" , "+5492914147880", "Managers", DatoUtilType::WhatsApp });
    m_datoUtil.append( { "Reglamento Rugby infantil", "", "", "http://www.clubchampagnat.com/wp-content/uploads/2015/03/Resumen_Reglamento_RI2015.jpg", "Reglamento", DatoUtilType::Web });
    m_datoUtil.append( { "Buscar Hoteles en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=hoteles+en+bahia+blanca", "Para Padres", DatoUtilType::Web });
    m_datoUtil.append( { "Buscar Restaurantes en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=restaurantes+en+bahia+blanca", "Para Padres", DatoUtilType::Web });
    m_datoUtil.append( { "Buscar Farmacias en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=farmacias+en+bahia+blanca", "Para Padres", DatoUtilType::Web });
    m_datoUtil.append( { "Buscar Hospitales en Bahia Blanca", "", "Bahia Blanca", "https://www.google.com.ar/search?q=hospital+en+bahia+blanca", "Para Padres", DatoUtilType::Web });
}

int DatosUtilesModel::rowCount(const QModelIndex &) const
{
    return m_datoUtil.count();
}

QVariant DatosUtilesModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < rowCount())
        switch (role) {
        case FullNameRole: return m_datoUtil.at(index.row()).fullName;
        case AddressRole: return m_datoUtil.at(index.row()).address;
        case CityRole: return m_datoUtil.at(index.row()).city;
        case NumberRole: return m_datoUtil.at(index.row()).number;
        case CategoriaRole: return m_datoUtil.at(index.row()).categoria;
        case TypeRole: return m_datoUtil.at(index.row()).tipo;
        default: return QVariant();
    }
    return QVariant();
}

QHash<int, QByteArray> DatosUtilesModel::roleNames() const
{
    static const QHash<int, QByteArray> roles {
        { FullNameRole, "fullName" },
        { AddressRole, "address" },
        { CityRole, "city" },
        { NumberRole, "number" },
        { CategoriaRole, "categoria"},
        { TypeRole, "tipo"}
    };
    return roles;
}

QVariantMap DatosUtilesModel::get(int row) const
{
    const DatoUtil contact = m_datoUtil.value(row);
    return { {"fullName", contact.fullName}, {"address", contact.address}, {"city", contact.city}, {"number", contact.number} };
}

void DatosUtilesModel::append(const QString &fullName, const QString &address, const QString &city, const QString &number)
{
    int row = 0;
    while (row < m_datoUtil.count() && fullName > m_datoUtil.at(row).fullName)
        ++row;
    beginInsertRows(QModelIndex(), row, row);
    m_datoUtil.insert(row, {fullName, address, city, number, "categoria"});
    endInsertRows();
}

void DatosUtilesModel::set(int row, const QString &fullName, const QString &address, const QString &city, const QString &number)
{
    if (row < 0 || row >= m_datoUtil.count())
        return;

    m_datoUtil.replace(row, { fullName, address, city, number, "categpria" });
    dataChanged(index(row, 0), index(row, 0), { FullNameRole, AddressRole, CityRole, NumberRole });
}

void DatosUtilesModel::remove(int row)
{
    if (row < 0 || row >= m_datoUtil.count())
        return;

    beginRemoveRows(QModelIndex(), row, row);
    m_datoUtil.removeAt(row);
    endRemoveRows();
}
