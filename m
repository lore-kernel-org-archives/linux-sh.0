From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Date: Wed, 24 Dec 2008 05:05:27 +0000
Subject: Re: [Linux-fbdev-devel] [PATCH 01/05] video: fix deferred io fsync()
Message-Id: <45a44e480812232105t49e226c5xdd604133dd10233b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
	 <20081219063409.2703.3880.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081219063409.2703.3880.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

On Fri, Dec 19, 2008 at 1:34 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm@igel.co.jp>
>
> If CONFIG_FB_DEFERRED_IO is set, but there are framebuffers
> registered that does not make use of deferred io, then fsync()
> on those framebuffers will result in a crash. Fix that.
>
> This is needed for sh_mobile_lcdcfb since we always enable
> deferred io at compile time but we may disable deferred io
> for some types of hardware configurations.
>
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>
