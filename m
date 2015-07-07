From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 Jul 2015 20:58:49 +0000
Subject: Re: [PATCH v3 0/3] Remove non-existing GPIO pins for R8A7790/1
Message-Id: <4071361.aKboP8jfz3@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1460630.GxHT4lRd7u@wasted.cogentembedded.com> <558DBB45.3020507@cogentembedded.com> <CACRpkdZNqkoz9xSikCgKdp3LGgQnb4BRcOuF0nnc1rd49aS6xQ@mail.gmail.com>
In-Reply-To: <CACRpkdZNqkoz9xSikCgKdp3LGgQnb4BRcOuF0nnc1rd49aS6xQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Linus,

On Monday 29 June 2015 12:43:09 Linus Walleij wrote:
> On Fri, Jun 26, 2015 at 10:51 PM, Sergei Shtylyov wrote:
> > On 06/26/2015 01:39 AM, Sergei Shtylyov wrote:
> >> Here's the set of 3 patches against the 'fixes' branch of Linus
> >> Walleij's 'linux-pinctrl.git' repo. Here we eliminate the pin array
> >> "holes" on R-Car SoCs and then remove unused GPIO pins for R8A7790/1.
> >> 
> >> [1/3] sh-pfc: fix sparse GPIOs for R-Car SoCs
> >> 
> > Note that this patch is necessary for the R8A7794 driver (already in
> > Linus' tree to work correctly.
> 
> Laurent is it OK to apply these three for fixes?

You can apply 1/3 as a v4.2-rc fix, as pfc-r8a7794 merged in v4.2-rc1 is 
broken without it. I would prefer delaying 2/3 and 3/3 to v4.3.

-- 
Regards,

Laurent Pinchart

