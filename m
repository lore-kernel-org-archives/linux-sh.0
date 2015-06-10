From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Jun 2015 12:11:50 +0000
Subject: Re: [PATCH v2 0/4] sh-pfc: handle pin array holes in sh_pfc_map_pins()
Message-Id: <55782986.7040208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4326653.qPvIJDU6F2@wasted.cogentembedded.com> <CACRpkdYXHbP0jhvNxojhh=Mr-NCe-ismBp7g5T5_vYLFDz9rtw@mail.gmail.com>
In-Reply-To: <CACRpkdYXHbP0jhvNxojhh=Mr-NCe-ismBp7g5T5_vYLFDz9rtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hello.

On 6/10/2015 10:49 AM, Linus Walleij wrote:

>>     Here's the set of 4 patches against the 'devel' branch of Linus Walleij's
>> 'linux-pinctrl.git' repo. Here we add proper handling of the pin array "holes"
>> and then remove unused GPIO pins for R8A7790/1 SoCs.

>> [1/4] sh-pfc: do not call sh_pfc_get_pin_index() when unnecessary
>> [2/4] sh-pfc: handle pin array holes
>> [3/4] sh-pfc: r8a7790 remove non-existing GPIO pins
>> [4/4] sh-pfc: r8a7791 remove non-existing GPIO pins

> Waiting for Laurent to review this series.

    Me too. :-)
    Note that the last 2 patches are Laurent's.

> Yours,
> Linus Walleij

WBR, Sergei

