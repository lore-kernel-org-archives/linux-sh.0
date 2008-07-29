From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Jul 2008 08:39:56 +0000
Subject: Re: [PATCH] sh: Fix compile error of Solution Engine
Message-Id: <20080729083956.GC29389@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <488EAC95.4060507@renesas.com>
In-Reply-To: <488EAC95.4060507@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: linux-sh@vger.kernel.org, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org

On Tue, Jul 29, 2008 at 02:37:25PM +0900, Nobuhiro Iwamatsu wrote:
> When I compiled Solution Engine, this become compile error
> because plaform device of sh_eth device becomes enable.
> When sh7710/sh7712 which could use sh_eth was chosen,
> revised it so that platform device of sh_eth device became enable.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Applied, thanks.
