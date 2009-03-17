From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 17 Mar 2009 07:15:06 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <20090317071506.GA28062@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 17, 2009 at 08:04:28AM +0100, Francesco VIRLINZI wrote:
> Hi Paul
> I see you moved the sh-mobile suspend code in a dedicated directory.
> 
At the moment it is SH-Mobile specific, so that is the best place for it.

> What do you think about my proposal on a generic sh4 suspend interpreter?
> 
While I don't have any real objections against the interpreter idea, this
is something you and Magnus will have to sort out. My expectation is that
this is something that will be gradually implemented and changed over
time, and we can certainly move code around whenever there is a need. For
now there are no non-shmobile parts that can use this code, so this is
the best place for it.

As we move to a more generic implementation, the SH-Mobile bits will
likely be simplified quite a bit, but the extra abstraction still makes
sense, as it is a common characteristic for this family of parts.
