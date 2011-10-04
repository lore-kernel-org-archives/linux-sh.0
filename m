From: Ben Dooks <ben-i2c@fluff.org>
Date: Tue, 04 Oct 2011 21:19:02 +0000
Subject: Re: [PATCH 1/2 v3] i2c: i2c-riic: add support for Renesas RIIC
Message-Id: <20111004211902.GD13323@freya.fluff.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E803ACC.3030403@renesas.com>
In-Reply-To: <4E803ACC.3030403@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: ben-linux@fluff.org, linux-i2c@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>

On Mon, Sep 26, 2011 at 05:41:48PM +0900, Yoshihiro Shimoda wrote:
> This driver supports the RIIC module. The SH7757 has it.
> The driver doesn't use any IRQ handler. This is because the module
> has errata in an interrupt. So, we cannot use the interrupt for
> transfer.

anyone care to comment on this driver? will add to next -next release.

-- 
Ben

