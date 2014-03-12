From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Mar 2014 22:20:09 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: rcar-gen2: Cache Mode Monitor Register Value
Message-Id: <CANqRtoSi_Z12hK=Ejq66Lso3OhvuYYt648Zx82OimUpUiB1jFw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394649890-23485-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394649890-23485-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Mar 13, 2014 at 3:44 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
>
> The MD pins are sampled at reset time, hence the read value will always be
> the same, and we can avoid the overhead of ioremapping the register on
> every read.

Thanks, this looks fine to me.

Now since we're adding overhead and optimizing, my personal take on
this would however be to take it one further step and consider
exposing the MD pins as a read-only GPIO controller and use DT to
associate the MD pins with the CPG. That would allow us to remove the
special casing.

Cheers,

/ magnus
