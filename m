From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 30 May 2018 11:08:28 +0000
Subject: Re: [PATCH] media: arch: sh: migor: Fix TW9910 PDN gpio
Message-Id: <4e636f8b-ba38-754a-4763-022eab578934@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1527671604-18768-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1527671604-18768-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp, dalias@libc.org, laurent.pinchart@ideasonboard.com, hans.verkuil@cisco.com
Cc: linux-sh@vger.kernel.org, linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org

Hello!

On 05/30/2018 12:13 PM, Jacopo Mondi wrote:

> The TW9910 PDN gpio (power down) is listed as active high in the chip

   GPIO.

> manual. It turns out it is actually active low as when set to physical
> level 0 it actually turns the video decoder power off.
> 
> Without this patch applied:
> tw9910 0-0045: Product ID error 1f:2
> 
> With this patch applied:
> tw9910 0-0045: tw9910 Product ID b:0
> 
> Fixes: commit "186c446f4b840bd77b79d3dc951ca436cb8abe79"

   That's not how you specify the "Fixes:" tag, please see
Documentation/process/submitting-patches.rst.

> 

   There shouldn't be an emoty line here.

> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
[...]

MBR, Sergei
