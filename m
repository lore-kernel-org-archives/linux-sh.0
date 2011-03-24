From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Mar 2011 06:25:12 +0000
Subject: Re: [PATCH] sh: Fix build alloc_thread_info_node function
Message-Id: <20110324062511.GA18002@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1300945660-8323-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1300945660-8323-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, eric.dumazet@gmail.com

On Thu, Mar 24, 2011 at 02:47:40PM +0900, Nobuhiro Iwamatsu wrote:
> By commit b6a84016bd2598e35ead635147fa53619982648d,
> alloc_thread_info was replaced by alloc_thread_info_node.
> However, the change of the function name and the addition of the argument
> were incomplete.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> CC: Eric Dumazet <eric.dumazet@gmail.com>

Applied, thanks.
