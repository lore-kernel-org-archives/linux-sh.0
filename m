From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Mon, 23 Feb 2015 05:08:16 +0000
Subject: Rcar-du Initialization errors on Koelsch
Message-Id: <54EAB5C0.5030304@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent-san
I am Hiep from Jinzai Solution.

We have tested the linux ver 3.19 on Koelsch, we found some error 
messages from Rcar-Du as show below:
The error messages:
"[drm] Initialized drm 1.1.0 20060810
  rcar-du feb00000.display: Failed to initialize drm fb helper.
  rcar-du feb00000.display: failed to initialize DRM/KMS
  rcar-du: probe of feb00000.display failed with error -22"

Then, we find out these patches as below are causing of this bug:
0ee56d4 ARM: shmobile: koelsch: Enable DU device in DT
910343e ARM: shmobile: koelsch-reference: Remove DU platform device

Please see them when you have time!

Best Regards,
Jinso/Cao Minh Hiep.

