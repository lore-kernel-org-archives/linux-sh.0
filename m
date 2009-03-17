From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 17 Mar 2009 10:35:58 +0000
Subject: Re: On "sh: Consolidate SH-Mobile CPU code in arch/sh/kernel/cpu/shmobile/."
Message-Id: <49BF7D0E.9040200@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49BF4B7C.2090607@st.com>
In-Reply-To: <49BF4B7C.2090607@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul, Magnus
>>     
> While I don't have any real objections against the interpreter idea, this
> is something you and Magnus will have to sort out. My expectation is that
> this is something that will be gradually implemented and changed over
> time, and we can certainly move code around whenever there is a need. For
> now there are no non-shmobile parts that can use this code, so this is
> the best place for it.
>
> As we move to a more generic implementation, the SH-Mobile bits will
> likely be simplified quite a bit, but the extra abstraction still makes
> sense, as it is a common characteristic for this family of parts.
>   
What do you think if we begin with a collection of all the shared 
requirement/constraint
 and after that we write on top of that the code required?

Regards
 Francesco
