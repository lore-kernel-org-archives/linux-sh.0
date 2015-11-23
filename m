From: =?UTF-8?B?7KGw7LC97ZmY?= <charlescho64@gmail.com>
Date: Mon, 23 Nov 2015 02:23:04 +0000
Subject: [Renesas-Lager][How to use IOMMU Hardware and test?]
Message-Id: <CANi_qo2amjsbU=i_ZAQkWMecSVkpA6A=KBBL6tYAmcVumiiiKg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Now I am researching how to use renesas lager board for IVI(In vehicle
Infortainments) based on XEN.  Especially I am wondering how to assign
some device to special guest and got the method that
passthrough(Direct IO) is right.

This method need hardware with IOMMU(SMMUv1 and SMMUv2 supported).

1. Is Renesas R-CAR Lager board supporting IOMMU?
2. If use this IOMMU, what should be configured? only kernel configure
file is changed with enabling "shmobile_iommu and
shmobile_iommu_addrsize_xxMB" in shmobile_defconfig file?
3. finally How to test the system with IOMMU enable or disable for performance ?

BR

Thanks

-- 
Happy Virus....
Chang Hwan, Cho
