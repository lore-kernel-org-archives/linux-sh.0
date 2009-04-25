From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 25 Apr 2009 14:42:53 +0000
Subject: Re: [OOPS] Kernel panic on boot with next-20090423 on migor
Message-Id: <aec7e5c30904250742q967b6afk5848bc66458306f7@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0904241534140.6968@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0904241534140.6968@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 24, 2009 at 10:47 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Addendum: only occurs with the SLQB (now default) allocator, not with
> SLAB.

Disabling NUMA may help.

/ magnus
