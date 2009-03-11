From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Mar 2009 03:00:05 +0000
Subject: Re: [PATCH] sh_clk: added clk_set_parent/clk_get_parent support
Message-Id: <aec7e5c30903102000r6451cf5ahaf82f4bcf8ecfe3d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B66867.2010406@st.com>
In-Reply-To: <49B66867.2010406@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Francesco,

Thanks for your work on this!

On Tue, Mar 10, 2009 at 10:17 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> I would add the following functions in the clock framework
> - clk_set_parent
> - clk_get_parent

1) I agree about adding the functions above.

> and the utility function
> - clk_for_each

2) As much as I like functions like this, where is this used?

(From patch header)
> - changes the callback function to return a value

3) These changes break other code. You need to update cpu/sh4a/clock-*
files as well. I agree about init and enable, but why does the disable
callback need to return something?

Please break out 1) and resubmit it inline to begin with. Let's deal
with 2) and 3) separately.

Cheers,

/ magnus
