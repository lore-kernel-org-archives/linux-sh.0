From: Rich Felker <dalias@libc.org>
Date: Fri, 04 Sep 2015 15:39:47 +0000
Subject: Re: [PATCH] common checksum code uses post-sh2 instruction
Message-Id: <20150904153947.GR17773@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <55E6FB54.9090800@landley.net>
In-Reply-To: <55E6FB54.9090800@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 02, 2015 at 08:36:20AM -0500, Rob Landley wrote:
> From: Rob Landley <rob@landley.net>
> 
> The common checksum code uses shld which sh2 hasn't got, so unwind it.
> 
> Note: http://nommu.org/jcore added SHAD and SHLD, and if anybody's
> building for an actual sh2 they'll either need gcc 4.7 or earlier or
> a fix to https://gcc.gnu.org/bugzilla/show_bug.cgi?idT089 but
> when regression testing against the actual historical hardware,
> you need this.
> 
> Signed-off-by: Rob Landley <rob@landley.net>
> ---
> 
>  arch/sh/lib/checksum.S |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/lib/checksum.S b/arch/sh/lib/checksum.S
> index 356c8ec..7f0fc6b 100644
> --- a/arch/sh/lib/checksum.S
> +++ b/arch/sh/lib/checksum.S
> @@ -88,8 +88,9 @@ ENTRY(csum_partial)
>  2:
>  	! buf is 4 byte aligned (len could be 0)
>  	mov	r5, r1
> -	mov	#-5, r0
> -	shld	r0, r1
> +	shlr2	r1		! mov	#-5, r0
> +	shlr2	r1		! shld	r0, r1
> +	shlr	r1

Is this a performance-critical code path (e.g. for networking)? If
not, I like your current solution best because it's simple and
#ifdef-free. But if it is critical and the shld is faster, perhaps
#ifdef for SH3+ would be appropriate, and we could expand to include
J2 in the #ifdef with the J2 support patches?

Rich
