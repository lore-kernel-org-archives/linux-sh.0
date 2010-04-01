From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 01 Apr 2010 10:12:49 +0000
Subject: Re: PFC of SCIF 1
Message-Id: <i2waec7e5c31004010312g8120fcaaxebee481cccd32225@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201004011136.26340.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004011136.26340.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 1, 2010 at 7:11 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> If the boot loader usually sets up the pinmux and if the kernel does
> not touch it then it will work. On SH the proper way to do this is to
> let the kernel use the GPIO framework to configure the pinmux using
> request_irq().

err, it's supposed to be request_gpio(). =)

/ magnus
