From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 10 Jun 2015 07:49:13 +0000
Subject: Re: [PATCH v2 0/4] sh-pfc: handle pin array holes in sh_pfc_map_pins()
Message-Id: <CACRpkdYXHbP0jhvNxojhh=Mr-NCe-ismBp7g5T5_vYLFDz9rtw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4326653.qPvIJDU6F2@wasted.cogentembedded.com>
In-Reply-To: <4326653.qPvIJDU6F2@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Jun 5, 2015 at 1:23 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:

> Hello.
>
>    Here's the set of 4 patches against the 'devel' branch of Linus Walleij's
> 'linux-pinctrl.git' repo. Here we add proper handling of the pin array "holes"
> and then remove unused GPIO pins for R8A7790/1 SoCs.
>
> [1/4] sh-pfc: do not call sh_pfc_get_pin_index() when unnecessary
> [2/4] sh-pfc: handle pin array holes
> [3/4] sh-pfc: r8a7790 remove non-existing GPIO pins
> [4/4] sh-pfc: r8a7791 remove non-existing GPIO pins

Waiting for Laurent to review this series.

Yours,
Linus Walleij
