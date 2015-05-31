From: Wolfram Sang <wsa@the-dreams.de>
Date: Sun, 31 May 2015 23:30:36 +0000
Subject: Re: [PATCH] i2c: check for proper length of the reg property
Message-Id: <20150531233035.GD17187@katana>
List-Id: <linux-sh.vger.kernel.org>
References: <1432052988-6187-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1432052988-6187-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

On Tue, May 19, 2015 at 06:29:48PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> int is vague, let's simply use the type of the variable in question.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!

