From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 05 Jan 2011 08:04:47 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0: fix div4 table
Message-Id: <20110105080447.GD23889@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 22, 2010 at 11:15:08PM +0900, Magnus Damm wrote:
> sh73a0 has divisor[12] setting as 1/7 on FRQCRA.
> 
> Signed-off-by: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
> Signed-off-by: Magnus Damm <damm@opensource.se>

On Wed, Dec 22, 2010 at 11:47:40PM +0900, Magnus Damm wrote:
> Add VGA camera support to the Mackerel board
> using soc_camera_platform.
> 
> The VGA camera module is hooked up using the
> 8-bit CEU bus, and it is constantly bursting
> out frames in fixed video mode setting. The
> camera module does not allow any I2C control.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Both applied, thanks.
