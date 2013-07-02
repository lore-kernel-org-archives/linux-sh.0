From: Simon Horman <horms@verge.net.au>
Date: Tue, 02 Jul 2013 03:30:47 +0000
Subject: Re: [PATCH] ARM: shmobile: emev2 GIO3 resource fix
Message-Id: <20130702033046.GC14567@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130701114807.29137.43972.sendpatchset@w520>
In-Reply-To: <20130701114807.29137.43972.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jul 01, 2013 at 08:48:07PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Fix GIO3 base addresses for EMEV2.
> 
> This bug was introduced by 088efd9273b5076a0aead479aa31f1066d182b3e
> ("mach-shmobile: Emma Mobile EV2 GPIO support V3") which was included in v3.5.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will try and get this included in v3.11 as a fix
and then added to v3.9 and v3.10 stable.


