From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 17 Apr 2009 02:07:38 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <aec7e5c30904161907s41535942u1ca2581e9667e9c2@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 16, 2009 at 11:22 PM, Francesco VIRLINZI
<francesco.virlinzi@st.com> wrote:
> Hi Magnus
>>
>> Yes, assembly stubs work fine for the SuperH Mobile sleep modes
>> implemented so far. I suspect that upcoming "R-standby mode" will be
>> easier to support with an interpreter though. Time will tell.
>>
>
> What do you mean with "R-standby mode"?

It's a SuperH Mobile specific standby mode where most hardware blocks
are powered off. So we need to restore many registers in the resume
path. I suspect some kind of interpeter will make saving and restoring
registers easier, especially the memory controller registers that need
to be re-initialized before the system memory can be taken out of
self-refresh.

Have a look at the following presentation for more information about
the standby modes on SuperH Mobile:

http://www.celinuxforum.org/CelfPubWiki/ELC2009Presentations?action=AttachFile&do=view&target=Runtime-Power-Management-on-SuperH-Mobile-20090407.pdf

Cheers,

/ magnus
