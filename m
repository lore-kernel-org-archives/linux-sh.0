From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Date: Mon, 14 Dec 2015 02:34:40 +0000
Subject: Re: [bug] kernel panic if writting data to mmc after suspendding
Message-Id: <566E2AC0.8060800@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <566A21D2.4080009@jinso.co.jp>
In-Reply-To: <566A21D2.4080009@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, ltsi-dev@lists.linuxfoundation.org, =?UTF-8?B?U2ltb24g44GV44KT?= <simon@horms.net>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: =?UTF-8?B?U+mWizEyL+WdguaIuFND?= <ryusuke.sakato.bx@renesas.com>, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, =?UTF-8?B?TWFnbnVzIOOBleOCkw==?= <magnus.damm@gmail.com>, Hisao Munakata <hisao.munakata.vt@renesas.com>

Hello Mr.Geert

While is testting LTSI-v4.1.13-rc1, we have found the following the 
failure of mmcif.
1. mount mmc block
2. write data to mmc block
3. suspend/resume
4. write data to mmc block one again => happen kernel panic
(Probability in this test procedure is 100%)

We have used git bisect to find cause of failure in LTS-v4.1.13 to 
LTSI-v4.1.13-rc1
and have found commit which cause failure.
(On LTS-v4.1.13 has not this failure)
  drivers: sh: Disable PM runtime for multi-platform ARM with genpd
  commit :cbc41d0a761bffb3166a413a3c77100a737c0cd7

Please confirm for this failure with error log on Lager(Rcar-H2).
Log:LAGER_ltsi-v4.1.13-rc1_copy-to-mmc-after-suspend-error_log.txt
Best regard,
Nguyen Viet Dung
