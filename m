From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 21 Oct 2008 12:41:40 +0000
Subject: Re: [PATCH] sh: update ov772x byte order on Migo-R
Message-Id: <20081021124140.GA2517@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081021122903.27876.33583.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081021122903.27876.33583.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 21, 2008 at 09:29:03PM +0900, Magnus Damm wrote:
> Update the ov772x byte sequence to enable byte swap. This to reflect
> the recent CEU driver change to follow incoming byte order.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

On Tue, Oct 21, 2008 at 09:31:07PM +0900, Magnus Damm wrote:
> This patch updates the pinmux code to use the boolean value for
> the function gpio_set_value(). Without this patch values other
> than 0 and 1 will result in incorrect GPIO settings.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.
