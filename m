From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Mar 2009 05:52:45 +0000
Subject: Re: [Proposal][PATCH] sh: Suspend in Ram on sh4
Message-Id: <aec7e5c30903182252j4a6fbe88k168743f6f614c932@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B66A0E.1020400@st.com>
In-Reply-To: <49B66A0E.1020400@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Mar 11, 2009 at 11:31 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
>> I'm not sure what the best way forward is. Are you planning on
>> submitting upstream support for some SoC?
>
> Not so easy submit the per SOC code also because we use an older kernel t=
han
> the original kernel.org (I'm on 2.6.23).

I see. The joys of old kernels. =3D)

>> =A0That would be nice so we
>> could share the same power management code.
>
> I'm already sharing this code for that reason.

I appreciate your effort. You may have noted that we cherry pick
certain parts of the code that you post. Accepting everything would of
course be better, but there is some hesitation since we don't have the
full picture of your code base.

In my opinion, the best way to add new interfaces or change existing
ones is to also submit code that is using your interfaces. WIthout
such code it's difficult to understand the reason behind the change.

I wonder if it would be possible to take a single cpu and a single
board from your out of tree code base, and add support for that system
upstream. Then we can tie in whatever interfaces to that code. This
may take quite a bit of time though, but it's probably worth doing in
the long term.

Also, please try to submit your patches inline if possible. It makes
review much easier. I use sendpatchset for this purpose.

Thanks for your help so far!

/ magnus
