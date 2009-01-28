From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 28 Jan 2009 10:03:34 +0000
Subject: Re: [bug report] dead lock (?) occur on ap325 board
Message-Id: <20090128100333.GA23380@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 28, 2009 at 06:29:13PM +0900, Takashi Yoshii wrote:
> Fix conditon checking expression of __mutex_fastpath_*
> 
> Signed-off-by: Takashi YOSHII <yoshii.takashi@renesas.com>

Yes, that looks fine. I'll queue this up, thanks.

If Morimoto-san wants to add his Signed-off-by or Acked-by, I'll add that
also.
