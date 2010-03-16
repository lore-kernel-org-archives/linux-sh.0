From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Mar 2010 11:35:45 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <aec7e5c31003160435j370a3ddbj550e6ade39915c0a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, Mar 16, 2010 at 8:25 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Hi all, I build a board with smsc 9118 eth chip; Of course I'm not sure t=
he hw
> is ok.

Not sure what is missing in your case, but if you want top optimize
your performance then this commit may be helpful:

http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=A30c89ad41099f58922e0941e346e7c4371655b9

/ magnus
