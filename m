From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Mar 2009 11:31:57 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <aec7e5c30903170431w2999a0cdo1e26e1733452ff61@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Francesco,

Sorry for not getting back to you earlier!

On Tue, Mar 17, 2009 at 7:35 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> What do you think if we begin with a collection of all the shared
> requirement/constraint
> and after that we write on top of that the code required?

Sure. Let's do it step by step. I like the idea of some kind of
interpreter, but I was hoping on that we can agree on something a bit
simpler.

My main question is: Do you really need to be able to load and save
data from the interpreter?

Right now your implementation has multiple tables. I'd prefer to just
generate a bunch of inline operations that we either load into the
cache or put in on-chip ram depending on processor type. Each
operation would be self-contained.

What are your requirements?

Cheers,

/ magnus
