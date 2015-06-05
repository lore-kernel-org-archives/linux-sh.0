From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 05 Jun 2015 22:32:21 +0000
Subject: [PATCH v5 0/3] Add Renesas R8A7794 PFC support
Message-Id: <4547979.iqiS3iOv3s@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

Hello.

   Here's the set of 3 patches against the 'devel' branch of Linus Walleij's
'linux-pinctrl.git' repo. Here we add the PFC support for the Renesas R8A7794
SoC. The patches teaching the PFC driver to deal with "holes" in the pin array
are necessary for these patches to work (I didn't create a single series due to
the different patch versions of these 2 series).

[1/3] sh-pfc: add R8A7794 PFC support
[2/3] sh-pfc: r8a7794: add MMCIF pin groups
[3/3] sh-pfc: r8a7794: add SDHI pin groups

WBR, Sergei

