From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Jun 2008 05:45:22 +0000
Subject: Re: [PATCH] sh: Fix compile error SH7763 setup code
Message-Id: <20080606054522.GC29591@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48464F4F.5040203@renesas.com>
In-Reply-To: <48464F4F.5040203@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 04, 2008 at 05:16:15PM +0900, Nobuhiro Iwamatsu wrote:
> SH7763's setup code use old DECLARE_INTC_DESC.
> There was a compile error because of this.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Applied, thanks.
