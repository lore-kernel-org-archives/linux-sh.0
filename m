From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 24 Jun 2008 04:05:10 +0000
Subject: Re: [PATCH 1/2] sh: Solution Enginge 7710/7712 SH-Ether support
Message-Id: <20080624040510.GD22526@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4858D562.30103@renesas.com>
In-Reply-To: <4858D562.30103@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 18, 2008 at 06:29:06PM +0900, Nobuhiro Iwamatsu wrote:
> Add support SH-Ether for Hitachi Solution Engine.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Wed, Jun 18, 2008 at 06:31:46PM +0900, Nobuhiro Iwamatsu wrote:
> Enable SH-Ether support and NFS userland support.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Wed, Jun 18, 2008 at 06:32:03PM +0900, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Wed, Jun 18, 2008 at 06:32:14PM +0900, Nobuhiro Iwamatsu wrote:
> sh_pcic_io_xxx function are very old.
> In linux-2.4, mrshpc_ss socket driver used this function.
> But there is not this driver to the present kernel.
> I deleted these cords and checked operation.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Thu, Jun 19, 2008 at 07:27:55PM +0900, Nobuhiro Iwamatsu wrote:
> The CPU of AP-325RXA is SH7723, but a CPU becomes selectable.
> This patch fixes this problem.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

These are all applied, thanks.
