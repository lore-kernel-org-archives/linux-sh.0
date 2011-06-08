From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 08 Jun 2011 06:51:17 +0000
Subject: Re: sh:fixed issue in xchg_u32 function when val==r15.
Message-Id: <20110608065110.GA26006@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D9DB4A5.4010002@st.com>
In-Reply-To: <4D9DB4A5.4010002@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 19, 2011 at 05:28:47PM +0100, Srinivas KANDAGATLA wrote:
> Attached is the reworked patch for potential gUSA rollback users.
> 
Sorry for taking so long to get back to this, it's been in my review
queue for awhile now but other things kept getting in the way.

This looks good for the cmpxchg bits, but I suspect we also have to make
the same fixes for atomic-grb.h and bitops-grb.h.

I've applied your patch now and will send it off for -rc3. I expect
you'll simply send incremental patches for the other two if necessary,
after which we can make sure that it also all finds its way back to
-stable.
