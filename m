From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 18 Nov 2010 05:57:53 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7372 USB0/IIC1 MSTP fix
Message-Id: <20101118055752.GB12227@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101117114400.12467.85516.sendpatchset@t400s>
In-Reply-To: <20101117114400.12467.85516.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 17, 2010 at 08:44:00PM +0900, Magnus Damm wrote:
> Fix a MSTP assignment problem in the sh7372 clock
> framework code. The USB drivers should attach to
> MSTP322 not MSTP33 where IIC1 is located.

Applied to rmobile/urgent, thanks.
