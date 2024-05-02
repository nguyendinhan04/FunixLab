create table Nhan_vien(
    Nhan_vien_id int primary key,
    ho varchar(50),
    ten varchar(50),
    dia_chi text,
    SDT varchar(12)
);


create table khach_hang(
    khach_hang_id int primary key,
    ho varchar(50),
    ten varchar(50),
    SDT varchar(12)
);

create table nha_cung_cap(
    nha_cung_cap_id int primary key,
    ten varchar(50),
    SDT varchar(12),
    dia_chi text
);

create table san_pham (
    san_pham_id int primary key,
    ten varchar(50),
    nha_cung_cap_id int,
    constraint san_pham_nha_cung_cap_fk foreign key (nha_cung_cap_id) references nha_cung_cap(nha_cung_cap_id)
);

create table don_vi (
    san_pham_id int,
    don_vi varchar(50),
    gia_ban decimal(13,4),
    gia_mua decimal(13,4),
    ngay_cap_nhat datetime,
    constraint don_vi_pk primary key (san_pham_id, don_vi),
    constraint don_vi_san_pham_fk foreign key (san_pham_id) references san_pham(san_pham_id)
);

create table don_ban (
    don_ban_id int primary key,
    thoi_gian datetime,
    tong_tien decimal(13,4),
    khach_hang_id int,
    nhan_vien_id int,
    constraint don_ban_khach_hang_fk foreign key (khach_hang_id) references khach_hang(khach_hang_id),
    constraint don_ban_nhan_vien_fk foreign key (nhan_vien_id) references nhan_vien(nhan_vien_id)
);

create table chi_tiet_don_ban (
    Chi_tiet_don_ban_id int primary key,
    don_ban_id int,
    san_pham_id int,
    so_luong int,
    don_vi varchar(50),
    constraint chi_tiet_don_ban_don_ban_fk foreign key (don_ban_id) references don_ban(don_ban_id),
    constraint chi_tiet_don_ban_don_vi_fk foreign key (san_pham_id,don_vi) references don_Vi(san_pham_id,don_vi)
);


create table don_mua (
    don_mua_id int primary key,
    thoi_gian datetime,
    tong_tien decimal(13,4),
    nha_cung_cap_id int,
    nhan_vien_id int,
    constraint don_mua_nha_cung_cap_fk foreign key (nha_cung_cap_id) references nha_cung_cap(nha_cung_cap_id),
    constraint don_mua_nhan_vien_fk foreign key (nhan_vien_id) references nhan_vien(nhan_vien_id)
);

create table chi_tiet_don_mua (
    chi_tiet_don_mua_id int primary key,
    don_mua_id int,
    San_pham_id int,
    Don_vi varchar(50),
    SO_luong int,
    constraint chi_tiet_don_mua_don_mua_fk foreign key (don_mua_id) references don_mua(don_mua_id),
    constraint chi_tiet_don_mua_don_vi_fk foreign key (San_pham_id, don_vi) references don_vi(San_pham_id, don_vi) 
); 


create table thong_tin_dang_nhap (
    nhan_vien_id int primary key,
    ten_dang_nhap varchar(50),
    mat_khau_ma_hoa varchar(50),
    constraint thong_tin_dang_nhap_nhan_vien_fk foreign key (nhan_vien_id) references nhan_vien(nhan_vien_id)
);