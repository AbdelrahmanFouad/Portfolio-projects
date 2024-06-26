-- fixing date format
alter table Nashvillehousing
add saledateconverted date;

update NashVilleHousing
set saledateconverted = CONVERT(date,saledate)

select saledateconverted from NashVilleHousing

alter table nashvillehousing
drop column saledate

--populate property address data

select a.ParcelID,b.ParcelID,a.PropertyAddress,b.PropertyAddress, ISNULL(a.propertyaddress,b.PropertyAddress) 
from NashVilleHousing a
join NashVilleHousing b on a.ParcelID=b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set propertyAddress= ISNULL(a.propertyaddress,b.PropertyAddress)
from NashVilleHousing a
join NashVilleHousing b on a.ParcelID=b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

-- breaking out address into individual columns
select SUBSTRING(propertyAddress,1,CHARINDEX(',',PropertyAddress)-1) address,
SUBSTRING(PropertyAddress, Charindex(',',propertyaddress)+1, LEN(propertyAddress)) address2
from nashvillehousing

alter table nashvillehousing
add address1 nvarchar(255);

update NashVilleHousing
set address1 =  SUBSTRING(propertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

select address1 from NashVilleHousing

alter table nashvillehousing
add address2 nvarchar(255);

update NashVilleHousing
set address2=SUBSTRING(PropertyAddress, Charindex(',',propertyaddress)+1, LEN(propertyAddress))

select address2 from NashVilleHousing

--using parsename
select PARSENAME(replace(owneraddress,',','.'),3),
PARSENAME(replace(owneraddress,',','.'),2),
PARSENAME(replace(owneraddress,',','.'),1)
from NashVilleHousing
where OwnerAddress is not null

alter table nashvillehousing
add ownerad1 nvarchar(255)
alter table nashvillehousing
add ownerad2 nvarchar(255)
alter table nashvillehousing
add ownerad3 nvarchar(255)

update NashVilleHousing
set ownerad1=PARSENAME(replace(owneraddress,',','.'),3)
update NashVilleHousing
set ownerad2=PARSENAME(replace(owneraddress,',','.'),2)
update NashVilleHousing
set ownerad3=PARSENAME(replace(owneraddress,',','.'),1)

select * from NashVilleHousing
where OwnerAddress is not null

-- changing N and Y to yes and no

update NashVilleHousing
set SoldAsVacant= case when SoldAsVacant='Y' then 'Yes'
when SoldAsVacant='N' then 'NO'
else SoldAsVacant
end
select soldasvacant from NashVilleHousing
group by SoldAsVacant

-- removing dublicates

WITH rownumcte as
(select * ,
ROW_NUMBER() over( 
partition by	parcelID,
				propertyaddress,
				saledate,
				legalreference
order by
				uniqueID) as rownum
from nashvillehousing
)
select * from rownumcte
where rownum>1
order by propertyaddress

--order by ParcelID

--removing unused columns
Select *
From PortfolioProject.dbo.NashvilleHousing


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
