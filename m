From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Apr 2011 16:53:15 +0000
Subject: Re: sh:fixed issue in xchg_u32 function when val==r15.
Message-Id: <20110407165315.GC8052@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D9DB4A5.4010002@st.com>
In-Reply-To: <4D9DB4A5.4010002@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 07, 2011 at 01:57:09PM +0100, Srinivas KANDAGATLA wrote:
> Recently we have discovered a bug in xchg_u32 function of GUSA_RB feature.
> This function breaks if one of the input parameter 'val' is r15.
> 
>     168:    02 c7           mova    174 <exit_mm+0x54>,r0
>     16a:    09 00           nop   
>     16c:    f3 61           mov    r15,r1
>     16e:    fc ef           mov    #-4,r15

The -4 here is part of the gUSA login sequence, so if you're seeing the
problem with gUSA based xchg_u32 it seems like you're going to have to
apply the same fix for all gUSA rollback users.
