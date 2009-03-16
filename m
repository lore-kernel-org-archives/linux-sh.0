From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 16 Mar 2009 11:01:38 +0000
Subject: Re: [PATCH v3] Add OHCI USB support for SH7786
Message-Id: <20090316110138.GC21433@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uk56vqg3t.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uk56vqg3t.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 12, 2009 at 05:40:15PM +0900, Kuninori Morimoto wrote:
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> v2 -> v3
> o use MACRO for USB init
> o Set PHY RST bit only setup is done
> 
> > Paul
> I asked to hardware engineer what is the register which has no name.
> The answer is "Specification", and we must set it before use USB.
> 
I guess we will have to live with that for now.. Applied,  thanks.
