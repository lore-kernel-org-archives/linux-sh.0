From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 03 Nov 2015 19:35:15 +0000
Subject: Re: [PATCH] sh_eth: fix typo in RX descriptor bit name
Message-Id: <56390C73.2030302@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2178116.o4gdOMzEUc@wasted.cogentembedded.com>
 <CAOJe8K1GbJ7N9YW31f8Ht8Qbb2av_vpeZPv7R60DuKV6vuDZKA@mail.gmail.com>
In-Reply-To: <CAOJe8K1GbJ7N9YW31f8Ht8Qbb2av_vpeZPv7R60DuKV6vuDZKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 11/03/2015 10:30 PM, Denis Kirjanov wrote:

>> Commit  7d7355f58ba4 ("sh_eth: Ensure proper ordering of descriptor active
>> bit write/read") did the right thing  but used too "heavy" barriers while
>> there were already "lighter" DMA barriers exactly  for this case...
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> Fix the subject line...

    Oops! Will fix in a jiffy...
    (I thought at first that you're commenting on the already applied patch. :-))

MBR, Sergei

