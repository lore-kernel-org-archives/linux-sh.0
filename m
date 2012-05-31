From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 31 May 2012 23:50:22 +0000
Subject: Re: [PATCH][RFC] ARM: mach-shmobile: setup-sh7372: fixup chclr_offset base
Message-Id: <20120531235022.GF11445@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 31, 2012 at 06:10:52PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 30 May 2012, Rafael J. Wysocki wrote:
> > I suppose this should go into v3.5, if possible, right?
> 
> I'm not sure in fact. On the one hand the fix looks correct. On the other 
> hand we haven't got any reports of this bug causing problems, that this 
> patch would fix. IIUC, sh7372 is not a very widely used platform these 
> days, so, pushing for 3.5 should be safe enough. Paul and Magnus certainly 
> know the situation better.
> 
Given that this is a correctness fix it should go in to 3.5 and possibly
marked for stable as well. The fact no one has reported bugs so far is
immaterial, given that few customers are running on upstream kernels
directly. The fact it's not in wide deployment helps, too.
