From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Mar 2009 10:10:18 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <aec7e5c30903250310x22464c83y9f783f908eea76f@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 3/24/09, Francesco VIRLINZI <francesco.virlinzi@st.com> wrote:

> > But do we (you!) really need to jump forward?
> >
> >
>  Not really but I'd like to have no constraint if possible

Then I vote for adding it later when there is a direct need. You can
implement delay using backward jump only, right?

>  Have you time to extend your code or is it ok for you if I do the required
> update?

Please write a patch youself for now. And feel free to post it if
you'd like. Don't spend too much time at this point though. Other
people may come up with better code...

Yoshii-san, any comments?

Cheers!

/ magnus
