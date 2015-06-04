From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Jun 2015 23:23:39 +0000
Subject: [PATCH v2 0/4] sh-pfc: handle pin array holes in sh_pfc_map_pins()
Message-Id: <4326653.qPvIJDU6F2@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

Hello.

   Here's the set of 4 patches against the 'devel' branch of Linus Walleij's
'linux-pinctrl.git' repo. Here we add proper handling of the pin array "holes"
and then remove unused GPIO pins for R8A7790/1 SoCs.

[1/4] sh-pfc: do not call sh_pfc_get_pin_index() when unnecessary
[2/4] sh-pfc: handle pin array holes
[3/4] sh-pfc: r8a7790 remove non-existing GPIO pins
[4/4] sh-pfc: r8a7791 remove non-existing GPIO pins

WBR, Sergei

