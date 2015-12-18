From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Date: Fri, 18 Dec 2015 02:01:56 +0000
Subject: Summary of LTSI-v4.1.13-rc1 test result on RENESAS SOC
Message-Id: <56736914.1030608@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

We have testted LTSI-v4.1.13-rc1 on the RENESAS SOC.
Bellow is summary of test result.
1) Target board:LAGER, KOELSCH, ALT
2) Total of test cases:
  LAGER  :488
  KOELSCH:502
  ALT    :49
3) Compare with LTS-v4.1.13 have two cases is failure.
4) Corresponding state of two failure:
  -Failure relate with rcar-thermal driver:
   Had resolution patch on Linux-Next branch(5de85b9 commit).
  -Failure relate with mmcif driver:
   In waitting countermeasure of Mr.Geert

   Best Regards,
   Nguyen Viet Dung
