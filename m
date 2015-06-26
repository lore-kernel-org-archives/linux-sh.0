From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 26 Jun 2015 20:51:17 +0000
Subject: Re: [PATCH v3 0/3] Remove non-existing GPIO pins for R8A7790/1
Message-Id: <558DBB45.3020507@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
In-Reply-To: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

On 06/26/2015 01:39 AM, Sergei Shtylyov wrote:

>     Here's the set of 3 patches against the 'fixes' branch of Linus Walleij's
> 'linux-pinctrl.git' repo. Here we eliminate the pin array "holes" on R-Car SoCs
> and then remove unused GPIO pins for R8A7790/1.

> [1/3] sh-pfc: fix sparse GPIOs for R-Car SoCs

    Note that this patch is necessary for the R8A7794 driver (already in 
Linus' tree to work correctly.

WBR, Sergei

