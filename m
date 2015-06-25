From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 25 Jun 2015 22:39:14 +0000
Subject: [PATCH v3 0/3] Remove non-existing GPIO pins for R8A7790/1
Message-Id: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

Hello.

   Here's the set of 3 patches against the 'fixes' branch of Linus Walleij's
'linux-pinctrl.git' repo. Here we eliminate the pin array "holes" on R-Car SoCs
and then remove unused GPIO pins for R8A7790/1.

[1/3] sh-pfc: fix sparse GPIOs for R-Car SoCs
[2/3] sh-pfc: r8a7790 remove non-existing GPIO pins
[3/3] sh-pfc: r8a7791 remove non-existing GPIO pins

WBR, Sergei

