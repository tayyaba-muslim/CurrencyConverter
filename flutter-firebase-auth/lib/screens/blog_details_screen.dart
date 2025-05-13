// // File: blog_screen.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_demo/screens/contact_screen.dart';
import 'package:firebase_auth_demo/screens/conversion_history_screen.dart';
import 'package:firebase_auth_demo/screens/currency_news_screen.dart';
import 'package:firebase_auth_demo/screens/customfooter.dart';
import 'package:firebase_auth_demo/screens/default_currency_screen.dart';
import 'package:firebase_auth_demo/screens/help_center_screen.dart';
import 'package:firebase_auth_demo/screens/home_screen.dart' as home;
import 'package:firebase_auth_demo/screens/login_email_password_screen.dart';
import 'package:firebase_auth_demo/screens/rate_alerts_screen.dart';
import 'package:firebase_auth_demo/screens/signup_email_password_screen.dart';
import 'package:firebase_auth_demo/screens/testimonial_page_screen.dart';
import 'package:firebase_auth_demo/services/firebase_auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth_demo/widgets/custom_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../widgets/blog_card.dart';

class BlogScreen extends StatelessWidget {
   final BlogPost post;

  const BlogScreen({Key? key, required this.post}) : super(key: key);

  static const List<BlogPost> blogPosts = [
    BlogPost(
      title: 'Dollar',
      summary: 'The Reign of the Worlds Most Traded Currency',
      content: '''In today’s hyperconnected financial world, one currency wields unmatched power and influence—the U.S. dollar. Often called the greenback, this iconic piece of American paper is more than just legal tender. It’s a symbol of global trust, a tool of international diplomacy, and a silent controller of economies. But how did the dollar achieve this dominance, and why does it continue to hold such a firm grip on the world?

The US Dollar isn’t just the currency of the United States—it’s the lifeblood of global finance. From oil deals in the Middle East to tech imports in Asia, the dollar rules international transactions. But how did it become so dominant, and what makes it stay on top? The dollar’s global dominance began after World War II with the Bretton Woods Agreement. This system pegged other major currencies to the dollar, which was itself backed by gold. Even after the gold standard ended in 1971, the dollar kept its power due to the strength of the US economy, political stability, and military and financial influence. Today, more than 60% of the world’s central bank reserves are held in dollars. Countries rely on the dollar to stabilize their economies and protect against currency risks. Its trust, liquidity, and worldwide acceptance make it the preferred reserve currency. The dollar is also the currency of global trade. Vital commodities like oil, gold, and gas are traded in dollars. This system, often referred to as the Petro-Dollar system, keeps global demand for the dollar high, even in transactions where the US isn’t involved. Beyond trade, the dollar is a powerful tool of influence. Because global payments often flow through US financial systems, the US can impose financial sanctions that block countries or companies from the dollar network. This makes it a non-military weapon used to isolate or punish regimes like Iran, Russia, or North Korea. The dollar is also a safe haven in uncertain times. During crises like wars, pandemics, or financial crashes, investors flock to the dollar. It’s seen as a stable store of value, and US Treasury bonds become highly sought after. This strengthens the dollar and gives the US financial advantages even during global turbulence. However, this dominance isn’t without consequences. Many developing countries borrow in US dollars. When the dollar strengthens, their debt becomes more expensive to repay, leading to inflation, slower growth, or financial crises in those nations. Even the US Federal Reserve’s decisions have global impact. When interest rates rise in the US, investors pull out of emerging markets, causing local currencies to weaken. The Fed’s policies ripple across continents, showing how central the dollar is to global finance. Lastly, the dollar’s dominance is self-reinforcing. Because everyone already uses it, it continues to be the default for trade, savings, and reserves. No other currency has yet matched its infrastructure, trust, and stability. While countries like China and Russia are working to reduce dependence on the dollar, and while cryptocurrencies are emerging, none currently offer the liquidity or trust needed to dethrone the greenback. For now, and perhaps for decades to come, the dollar remains king.
      
The Dollar as the Global Reserve Currency
One of the biggest reasons behind the dollar’s strength is its role as the global reserve currency. Around 60% of all central bank foreign reserves are held in U.S. dollars. Countries around the world trust the dollar to stabilize their own economies and protect against currency shocks.

This status began after World War II with the Bretton Woods Agreement, which pegged global currencies to the U.S. dollar, itself backed by gold at the time. Even after the gold standard was abandoned, the dollar retained its crown due to the sheer size and stability of the U.S. economy.

Dominating Global Trade
The dollar is the default currency for international trade, especially for vital resources like oil, gas, and gold. Whether it's a crude oil deal between China and Saudi Arabia or a tech purchase from Europe, chances are the transaction is settled in dollars.

This gives the U.S. a quiet yet powerful advantage—it becomes the middleman in most major trade deals, even when the U.S. isn’t directly involved. Other currencies simply don’t have the same level of trust, liquidity, or reach.

Sanctions: The Dollar as a Weapon
The dollar isn’t just a tool of trade—it’s also a weapon of control. Since most global transactions flow through U.S. banks or are cleared in dollars, America can use financial sanctions to cut off countries, companies, or individuals from the global economy.

Nations like Iran, North Korea, and Russia have felt the bite of this power. Being locked out of the dollar system can cripple economies and isolate regimes, giving the U.S. immense geopolitical leverage without firing a single shot.

A Global Safe Haven
During times of crisis—whether it's a war, pandemic, or market crash—investors flee to the safety of the dollar. It’s considered the world’s most reliable store of value. That’s why, in turbulent times, the dollar typically strengthens, and U.S. Treasury bonds become hot assets.

This global faith in the dollar allows the U.S. to borrow money at lower interest rates and maintain a strong economic position even when other countries are struggling.

Dollar-Denominated Debt: A Double-Edged Sword
Many countries and companies borrow in U.S. dollars due to its stability. But when the dollar strengthens, repaying that debt becomes more expensive. This creates financial stress in emerging markets, leading to inflation, defaults, or economic slowdowns.

Ironically, while the dollar gives global access to capital, it also becomes a burden when exchange rates shift, reinforcing American dominance and deepening dependence on the greenback.

The Fed’s Global Influence
The Federal Reserve—America’s central bank—doesn’t just set monetary policy for the U.S. It influences the entire world. When the Fed raises interest rates, capital flows out of developing countries and into American markets. This can trigger currency crashes and inflation overseas, showing how decisions made in Washington ripple across continents.

A Self-Reinforcing System
The dominance of the dollar is held up by a powerful network effect. Because everyone already uses it, new players prefer to stick with it, whether they’re building central bank reserves or conducting trade. This creates a cycle where the dollar remains on top, simply because it's already on top.''', 
      imageUrl: 'https://images.pexels.com/photos/164527/pexels-photo-164527.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    BlogPost(
      title: 'Euro',
      summary: 'Beyond Borders: The Euro and European Unity',
      content:'''The Euro is not merely a currency — it is a revolutionary idea that reshaped the political, social, and economic fabric of Europe. Designed to unite diverse nations under a single monetary system, the Euro today stands as a global powerhouse, symbolizing strength, cooperation, and shared destiny.
But how did this ambitious project come into existence? Let's journey through the story of the Euro.
Historical Background: Seeds of Unity
After the catastrophic destruction of World War II, European nations realized that lasting peace could only be achieved through deep economic and political integration.
The first steps came with the formation of the European Coal and Steel Community (ECSC) in 1951, followed by the Treaty of Rome in 1957, which created the European Economic Community (EEC).

The idea was simple but powerful: nations that trade together and share economic interests are less likely to go to war.
Economic unity was seen as a foundation for political unity — and eventually, a shared currency would be the strongest symbol of that unity.

The Birth of the Euro
The dream of a single European currency became serious during the 1970s, but multiple financial crises delayed progress.
Finally, in 1992, the Maastricht Treaty formally established the blueprint for a common currency and economic convergence.

Key milestones:

1999: The Euro was introduced as a digital accounting currency for electronic payments and banking.
2002: Euro banknotes and coins were launched across 12 European countries, replacing their national currencies.

For the first time in history, sovereign nations voluntarily gave up their individual currencies in favor of a shared future.
The Euro thus became a unique experiment — never before had so many independent states agreed to use a single currency without a full political union.

Vision Behind the Euro
The creators of the Euro envisioned:

1) Economic Stability: Strengthen Europe's economy by eliminating currency fluctuations.
2) Deeper Political Bonds: Build trust and cooperation among member nations.
3) Global Influence: Position Europe as a major player against giants like the United States and China.
4) Convenience: Simplify cross-border trade, investment, and travel.

The Euro was meant to make Europe not just a collection of countries, but a true single market with seamless movement of goods, services, capital, and people.

The Eurozone: A Club of Shared Destiny
Today, the Eurozone includes 20 countries that have adopted the Euro as their official currency.
Together, they form a single monetary bloc governed by the European Central Bank (ECB).

The ECB controls monetary policy for the entire Eurozone, ensuring:

1 ) Inflation remains low and stable
2) Financial systems remain strong
3) Economic growth is sustainable

Countries like Germany, France, Italy, and Spain are major players, but smaller nations like Estonia and Slovenia also contribute to the richness of the Eurozone.

Advantages of the Euro
The Euro has unlocked numerous benefits:

1) Trade Boom: Cross-border business became faster, cheaper, and more predictable.
2) Travel Made Easy: No more changing currencies when traveling across most of Europe.
3)Price Transparency: Consumers can compare prices directly across countries.
4) Global Stability: The Euro provides a balance to the dominance of the U.S. dollar.
5) Political Integration: The currency acts as a daily reminder of a shared European identity.

Struggles and Criticism
Despite its successes, the Euro has faced serious hurdles:

Debt Crises: Countries like Greece, Portugal, and Ireland faced economic collapses in the late 2000s.

Diverging Economies: Wealthier countries like Germany have very different economic needs compared to countries like Greece or Spain.

Limited Flexibility: Member countries cannot print their own money or adjust exchange rates during a crisis.

Public Backlash: In some countries, the Euro was blamed for rising prices and economic hardship, fueling Euroscepticism.

The Euro’s Global Role
Today, the Euro is:

The second most used currency worldwide (after the U.S. dollar)

Widely used in international trade deals, central bank reserves, and financial markets

A symbol of Europe’s collective power in a globalized economy

Around 20% of global foreign exchange reserves are held in Euros, proving its strength and influence on the world stage.

The Euro and European Identity
More than economics, the Euro is a cultural and political bond:

People from different languages and traditions use the same currency daily.

The shared currency strengthens the sense of belonging to something larger than national borders.

Euro coins even celebrate national diversity, with one common side and one side unique to each country.

The Euro quietly weaves a story of unity into the daily lives of millions of Europeans.

The Road Ahead: Future of the Euro
The Euro's journey is still unfolding:

Digital Euro: Efforts are underway to launch a Central Bank Digital Currency (CBDC) version of the Euro.

Stronger Fiscal Unity: Discussions continue about deeper integration, including shared budgets and taxes.

Expansion: More EU countries are preparing to adopt the Euro in coming years.

Sustainability Focus: Green economic policies will play a central role in the Eurozone’s evolution.

The Euro will need to adapt to technological innovation, climate change, political shifts, and economic challenges to remain a powerful force in the 21st century.''',
      imageUrl: 'https://images.pexels.com/photos/158776/euro-money-currency-the-european-158776.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
    BlogPost(
      title: 'Pound',
      summary: 'Legacy Currency: The Pound’s Prestige & Power',
content: '''Birth of the Pound Sterling
The British Pound Sterling has an extraordinary heritage that dates back over 1,200 years. Its story begins during the reign of King Offa of Mercia in the 8th century.
Around 775 AD, Offa introduced the silver penny as a standard unit of currency across his kingdom. A Pound was originally defined as the weight of one pound of sterling silver, from which the currency took its name.
At that time, 240 silver pennies made up one Pound, establishing a monetary system that would influence British finance for centuries.
The term “Sterling” signified the high-quality silver used, and this reputation for purity and reliability set the foundation for Britain’s long-standing economic influence.

Growth During the Middle Ages: A Symbol of Wealth and Power
During the medieval period, the Pound became not just a means of trade, but a symbol of royal authority and national wealth.
Even though common people rarely held large sums, major transactions like land purchases, taxation, and debts were all calculated in Pounds, Shillings, and Pence.
The Royal Mint, established in London’s Tower of London, standardized coin production under the crown’s supervision, ensuring the Pound remained a trusted unit of value.
Over the centuries, monarchs like William the Conqueror and Henry II left their marks on England’s monetary system, while the Pound evolved into a recognized standard across Europe.

The Pound and the Rise of the British Empire
As Britain expanded into a global empire during the 16th to 19th centuries, the Pound Sterling traveled with explorers, merchants, and colonial administrators.
The currency became a vital tool in establishing Britain's dominance over international trade routes spanning North America, Asia, Africa, and Australia.
The founding of the Bank of England in 1694 marked a turning point, introducing paper banknotes backed by gold and silver reserves.
The Pound’s strength reflected Britain's political, naval, and commercial power, and London emerged as the world’s financial capital, with the Pound as the world's premier trading currency.

Golden Age: The Pound Under the Gold Standard
The 19th century ushered in the Pound’s golden age with Britain’s adoption of the Gold Standard in 1816.
This meant that every Pound note was backed by a fixed quantity of gold, giving international traders and governments immense confidence in the British currency.
London’s financial markets thrived, and the Pound Sterling became the world's dominant reserve currency.
For much of the 1800s, Britain’s industrial revolution and colonial expansion ensured that Sterling was the backbone of the global economy, rivaled by none.

War, Crisis, and Decline: Sterling Faces Challenges
The outbreak of World War I in 1914 marked the beginning of significant challenges for the Pound.
Britain had to suspend the Gold Standard to finance its war efforts, causing inflation and economic instability.
Although the country attempted to return to the Gold Standard briefly in 1925, the Great Depression forced its permanent abandonment in 1931.
World War II further strained Britain's economy, and by the late 1940s, the U.S. Dollar replaced the Pound as the primary global reserve currency.
Despite losing its preeminent status, the Pound continued to symbolize British resilience through economic reconstruction and social change.

Decimalisation: Modernizing the Pound
For centuries, Britain’s monetary system was notoriously complex, with 240 pence in one Pound and 12 pence in a shilling.
On February 15, 1971, famously known as "Decimal Day," Britain reformed its currency system to make it simpler:

1 Pound = 100 new pence.

This modernization made the Pound easier to use both domestically and internationally, aligning the UK’s financial system with the rest of the modern world.

The Euro Debate: Choosing Sovereignty Over Integration
In the late 1990s, as the European Union introduced the Euro, Britain faced immense political debate over whether to adopt the new currency.
Despite pressures from businesses and some politicians, public opinion strongly favored keeping the Pound.
Many British citizens viewed the Pound not just as a currency, but as a symbol of national identity, heritage, and sovereignty.
Ultimately, Britain opted out of the Eurozone, maintaining the Pound Sterling and reinforcing its importance to British national pride.

Unique Features of the Modern Pound
Today’s Pound notes and coins are rich in symbolism and history.
New polymer banknotes feature detailed portraits of British icons such as Winston Churchill, Jane Austen, and Alan Turing.
Coins feature emblems representing the four nations of the United Kingdom: the English Rose, the Scottish Thistle, the Welsh Leek, and the Northern Irish Shamrock.
Furthermore, Scotland and Northern Ireland issue their own unique designs of Pound banknotes, reflecting regional identities within the UK.

Timeline: Key Milestones of the British Pound
775 AD — King Offa introduces the silver penny.

1158 — King Henry II standardizes the English currency system.

1694 — Bank of England founded; first Pound banknotes issued.

1816 — Britain formally adopts the Gold Standard.

1931 — Permanent exit from the Gold Standard.

1971 — Decimalisation simplifies the Pound system.

1999 — Britain decides against joining the Euro.

The Enduring Power of the Pound Sterling
The story of the British Pound Sterling is the story of Britain itself — a journey through kingdoms, empires, wars, revolutions, and globalization.
Despite facing immense global challenges over the centuries, the Pound remains a resilient and highly respected currency, trusted both at home and abroad.
In an era where many currencies have disappeared or been replaced, the Pound Sterling continues to stand tall, reflecting over a millennium of history, strength, and tradition.

To this day, holding a Pound note is like holding a tangible piece of history — a symbol of a nation that shaped the world.
''',
      imageUrl: 'https://images.pexels.com/photos/1791583/pexels-photo-1791583.jpeg?auto=compress&cs=tinysrgb&w=400',  
    ),
    BlogPost(
      title: 'Rupee',
      summary: 'Rising Rupee: India’s Growing Global Footprint',
      content: '''The Rupee has one of the longest and richest histories among world currencies.
Its roots trace back to the 16th century, during the rule of Sher Shah Suri, an Afghan ruler who controlled much of northern India.
In 1540, Sher Shah introduced a standardized silver coin called the "Rupiya," weighing around 178 grains (approximately 11.53 grams).
The term “Rupiya” comes from the Sanskrit word “Rupyakam,” meaning "wrought silver" or "a silver coin."
Before the Rupiya, various regions in India used different forms of metal-based money, but Sher Shah’s reform unified the system, making trade and governance much more efficient across the Indian subcontinent.
His innovation laid the foundation for India's monetary tradition, which survived multiple dynasties, colonizers, and modern economic transformations.

Evolution Through Mughal, Maratha, and Colonial Periods
Following Sher Shah, the Mughal emperors continued using the Rupiya.
Akbar the Great (1556–1605), a visionary ruler, established a well-organized financial system based on the silver Rupiya.
Under the Mughal Empire, the coinage was highly respected for its purity and uniformity, helping India's trade flourish with Persia, Arabia, and even parts of Europe.

Later, during the Maratha Confederacy and various princely states' rule, local variations of the Rupiya appeared, yet the core idea of a silver-based currency stayed intact.
With the rise of British East India Company in the 18th century, the Rupee was absorbed into the colonial system.
The British gradually shifted coin production to mints they controlled and standardized the design of Rupees under Queen Victoria’s authority.
By the 19th century, the Indian Rupee had become a critical part of global trade networks across Asia and Africa, under British imperial influence.

Transition from Silver Standard to Paper Currency
Originally, the Rupee was strictly linked to silver, unlike the British Pound, which was gold-backed.
As the global price of silver fell in the late 19th century due to massive discoveries of silver mines in the Americas, India’s silver-backed Rupee lost value compared to gold-backed currencies.
To manage this crisis, the British colonial administration introduced Paper Rupees in 1862 — marked by the Queen's portrait and issued by the Government of India.

This marked a critical shift — from a purely metallic standard to a modern monetary system based on the faith and stability of government-issued paper money.
Banks were established, and the use of the Rupee in large commercial transactions became widespread.
Despite colonial exploitation, this period laid crucial groundwork for India's later economic development.

A Currency of Sovereignty
With India's independence in 1947, the Rupee underwent not just a visual makeover but also a philosophical one.
Gone were the symbols of colonial power.
They were replaced with national symbols like the Lion Capital of Ashoka, portraits of Mahatma Gandhi, and images showcasing India's rich cultural and technological heritage.

The first post-independence note — a 1 Rupee note — still carried King George VI’s image briefly before it was replaced in 1949 with completely Indian motifs.
The Indian government established the Reserve Bank of India (RBI) as the sole issuer of currency, giving the Rupee its modern-day governance structure.
Thus, the Rupee became a symbol not just of commerce, but also of India’s pride, self-reliance, and national unity.

Major Events: Devaluation, Economic Liberalization, and Globalization
The Rupee’s journey was not without hardship.
In 1966, under pressure from the International Monetary Fund (IMF) and due to a growing balance of payments crisis, India devalued the Rupee drastically against the US Dollar.
This move was highly controversial and reflected India's struggle to balance its socialist economic model with global trade realities.

Again in the 1990s, facing a severe financial crisis, India undertook sweeping economic reforms under the leadership of Dr. Manmohan Singh, then Finance Minister.
The liberalization policies of 1991 opened India’s markets to foreign investment, drastically changing the Rupee’s role.
The Rupee became convertible on the current account in 1994, meaning it could be freely exchanged for foreign currencies for trade purposes — a massive leap towards globalization.

Modern Era: Technology, Security, and the Rise of the Digital Rupee
Fast forward to today, the Rupee is adapting to new challenges posed by technology and global finance.
In 2010, the Indian government introduced a unique currency symbol (₹), blending Indian and Latin script elements — a move to brand the Rupee internationally, similar to the Dollar and Euro .

In 2016, India announced a sudden demonetization of the 500 and 1000 Rupee notes to curb black money and corruption, reshaping the public’s interaction with physical currency.
New notes with improved security features — including color-changing ink, micro-lettering, and see-through registration marks — were introduced.

Now, with the Digital India mission, the Digital Rupee (CBDC) project is underway, preparing India to launch a central bank digital currency that could revolutionize banking, reduce transaction costs, and make financial systems more efficient.

The Global Presence and Symbolism of the Rupee
The Indian Rupee is widely accepted in neighboring countries like Nepal and Bhutan.
It holds a unique status among global currencies, not just because of India's population size, but also due to its fast-growing economy and influence in global affairs.

Moreover, the Rupee's design — with 15 official languages printed on every note — reflects India’s diverse and inclusive culture.
From intricate architectural designs on banknotes to the portrait of Mahatma Gandhi, the Rupee tells the world a story of unity in diversity, resilience, and progress.

Timeline of Major Milestones
1540 — Rupiya introduced by Sher Shah Suri.

1600s-1800s — Mughal and British versions of the Rupiya dominate.

1862 — Introduction of Paper Rupees under British India.

1947 — Indian Independence; new national Rupee begins.

1966 — Major devaluation of the Rupee.

1991 — Economic liberalization begins.

2010 — Introduction of the ₹ symbol.

2016 — Demonetization and introduction of the new series.

2023-24 — Pilot launch of India's Digital Rupee (CBDC).

Interesting Facts About the Rupee
The first Indian banknote (₹10) was printed under the British in 1861.

Nepal and Bhutan accept the Indian Rupee at par value in their countries.

Each Indian banknote shows 15 languages besides Hindi and English.

The highest denomination note in Indian history was ₹10,000 (now demonetized).

The Rupee — More Than Just Money
The Rupee is not merely a tool for transactions; it is a symbol of India’s heritage, a witness to its struggles and triumphs, and a beacon of its future aspirations.
From the silver coins that ruled ancient bazaars to the secure, digitally-enabled currency shaping a trillion-dollar economy today, the journey of the Rupee mirrors the story of India itself — dynamic, resilient, and forward-looking.

As India continues its journey toward becoming one of the world's leading economies, the Rupee will remain a pillar of national pride, standing testament to centuries of economic, political, and cultural evolution.''',
      imageUrl: 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMTEhUTExMWFhUWGBoYFxgYFx0aHRodGRcaHhgYGBgaHSggGh0lHRcYIjEhJSkrLi4uGCAzODMtNygtLisBCgoKDg0OGxAQGzgmHyUvLS0tLS0tLS0tLS8tLS0tLy8vLy8tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLi0tLf/AABEIAKgBLAMBIgACEQEDEQH/xAAcAAACAwEBAQEAAAAAAAAAAAAEBQIDBgABBwj/xAA/EAABAgQEAwUGBAQGAwEBAAABAhEAAwQhBRIxQVFhcQYigZGhEzKxwdHwQlJi4RQVkvEHIzNygsJDU6KyFv/EABoBAAMAAwEAAAAAAAAAAAAAAAIDBAABBQb/xAAxEQACAQMDAQYEBgMBAAAAAAABAgADESEEEjFBBRMiUWGRgaHR8CNCcbHB8RQy4UP/2gAMAwEAAhEDEQA/AF5xJc2UxDLQciuu6h1EPez0nNNnBQBy5Up5ApBceJ9Iy2GTHnz0/hJT/UB89I02HrVLnCYGIUgIWNC6fdUPAsRAK2bzsuQEKr5fQ/WWVFNlWFCzTZamGhJUAf8A9GNfViwPOMjOm550uWCCcwWvkE3APMlvKNTiFQyGHvHQRneBULGBV3MUvBZE0CWq/ukkecEpqxlBe7aQApACcr3I+MTlSbAaxEhZfDKO7S1zGyJgIu0AJkoROC8wc7RyGDCAsRp1KUnKNNxBu/BtMo0skXsDNIS8YzE5GSYpOzuPGNXJ0AKrtCnFkpMy1yBeM1HiW8zQt3dQjpM+El49lyiVMkE9I9rZ6UsnUvdtvGNOmWESgZYAdtn1iUUW6yup2gguEyYNSSlBIQUFtDCuvp8pCFWALuNSNo0dKskXd+YaFOKSSslWuW1oYCyHEjBWudtQYMCRSoVZK26xLEZIAEpLEq1PDnE8NpAol9Bq8OaHD0BRIT4u8WU624cTnajs0U3IU4lWDSShBSzJMN5SBFU2ZlZ2bR4mZ7NzgiwJzDp0Si2EpqqoSyMzZdIvqaNExGmtwYqq5CFjvNFdJWISRKzaCzwF7GzcGP2naGS+4cxDVyFS1FKvA8YDMyNfiNKmYljrsYyyqUpd9REdaltOOJ1dLqBUXPMoALvpDV0zpJRMu/y0MC09PmWEEsD69IfKMuUyQn75mBphgbiBqqqmyWuYpqQTKAILp36RCTUkgOdNHjRUU5JsR3uenhBq0A2N+UULT3ZvIzqzT8JWK0VWZIY3EUImKClAaG8dXYUQSZKmOpQ/qIUfzKYLMHFiCGblB7HJtFvWoU03X56dY/plqDvFWIzlBDgs0KKPHHcTEabiDhikkhiTfYiDNNrWiaesoM26M8NqitAJF94X45ROQvTYxR/N0oDI8hA1TjZXbLYX1jNjMliJg1lGlW3K2PeCzJeUEwzosPQE+0V3nvaEVRNK9dDtwh32WqQpCpSjdOnSEnT7Bcwm7VNZiqYH7w00suYkjLY2gTEacqkMfeR8v2gxCsi2LAaa3giZKcsNxGbekxKhBDeUyaqZx3S8LqgEFmNuEOhKKCuWXzaBvNJhdNkTHPeT4/3humQE3Im+1K7LTAB5P8TKYRKEsNq9zd3J1eGyXLDOsDgFEesJ6ZYDKJG1wPlDeRUj8pvxsI0W8hL1W/SH0csIukbv+5feNhhlISkrWXURblbaMXIKlXUdDYDTl1MbvBSfZh4ZSp3O5vh6ROsBVAYhx6Wp0kAmxBIvoX/7RnVziFpyqIIN7xsMbplKlqTLSoqBsBxuAfAsYzmIykBZzAguNAzkDvG+zw7aBOBrS5fnGLQiXjcwasW4xOdjqgxUkaaAmFZR5uOjbxAqa7sI0UU8iTjVVU4aMZuLTG7qiAdhtAq6pZ1US+sVJNnfiY6Wrx6/KMCDyi21FVjlj7yubdJbjG3w2Znpk/7eLac4xU5LuPhuY1fZFClSGtYkMecJrA9JZoWFyDC8NUxI43DqcwjrcV9jiHsVe5UIBTwzJsR4hvKHdJJV7QB76HusN2+EY3/GGjXLRTz0m6JjPwcOPUQpUYtxOl3gQXj1U4ylkA2VtBlBWFKncMYW4VOl1lGicgMoDvcQoe8IqGjgxNdla07FMpXS80U9QU97HaKJQcd7UQmTPULAmK5mILOiyBDqamoZLqqi6VcnngdZpwWA1gWupSopUlrX+zGcpsZnJcZnbR4vVjUw2cAb2h5oEi05ydqIpvaayXWJADs+5JtCfE8SlqUSCCAGtvCGdWLWe8XSBEaVBUcoOp9OJgzSG3xGTHtBg/4K5MMkpVNmBQ7uVi/AcI0LvqX6wFTyQgMnx59YqXNUshklUoOF5T3lag5BuEnUi/DnO5ucCdHTJ3a3c5PJhH8clMzIylJDZsqVEpfQs3uniP3GgK1uMjZWu+r7c4QUgTToC5yypYzZXOibAG902ZxxUwGgiC8emO4GVOxVLU3LvBT/APzBLZRmE96h8PHrNHJkZgDMAK7hxwfRxyiqrweWtIBFwGCt/E7wBQdoUKUlE0CWtXuF3Qv/AGr48ixh6lUMR7SSspOG9unwmDxDCFyVEkug78f3gVD2uPpH0WbLCgUqAIOoI1jOYp2dZ1SrjdJ1/wCJ36GKVYGcyrpyuVmdB1U3jEFGxIFyxgpVGo2EtXRjExhc0/8AjUeFo3cSXYx6QUXDeP8AaOoawypqV7GxhhJwKeojuFIgg9nVCxuTs4fqBC6hUixlWmoVS24fM2jarBLKAJe3nvFlLMUQFNobwZh9KpMvIu+w6c4GohlWpN2091h5wgUvWdLvLYtAu0MvIr2mygxPS48w8ZpYSS7s+zAxqe1OMClkCZMlKmJCgk5WLOWBL7aRjK//ABFp5KyhdGsKAB0SdRxBh6eG5tzJ696oCk8TGSlPoBwZn8oeUrAgHUs7W02aFEpC/wAo8PnDnC0KcBh1f1hQE9KrC0aU4ue6R8AdY2PZ9boeM7TTU5mdiFW3eNDQVIIAQmws5sPDjDUxJdSWZLARgCyy+jP8P3jlqTNJQZYWBrm08LdfKK5Vpgg1NI4UoLIUoguw2NgX1DMPAQy0jIUCzRLWdmJaroORX5feT9RCWp7MzxYAKvqD8jGxMuY7uk20BIHkxbziimqmJC3Cipg+mgZuA2cs5flGGStoqb5HymVk9mJ7NlA6qEEyeys0nvlDbhz9I1omREVidHHnAEGKGiUcCZo9nUJUEBQzkOAUlm3vtD3C8MTJBy2B24QZ/EJ14RRNxFI0Cj0ST02hVrHMoPAAW3wH0g66Q5yrKSc1u9s4e0If8VaP2mGzj/68sz+lQf0eHS8aP4aecr/iB01UOcL+0uNJFFPM6RNQgy1B1JSR3rJcBR3IgwYsg9Z8s/wqx32VQqSS8qa19kr28xbyj6FXUmSadkquOo1EfF14rMKcvdSLHupAuNDH17AMW/jqNKh/qosrkpPyI+MT6ql+YSrs/UbW2mTXTlnBBDHl8YDpkq0KU5TqoqSWblwg9E3MgJBUFvZIez+8D4wsVKKfempzcMqVq9EweltY2i+2L7lJ9ZXNp0Mlfu5g7a7sWfYtaKHs4vd/2Ii2qlvqsl2upJT0AJDDpaA0A5vZgXJbhfgTFRsJxdt5apQBJ8hDnC5fs0hwxIvy5QDMoVSlpEwpchwl3bg/r5QbMqTkUQkqIBISNSwsIkrPuO0TqaLT7PxG56S/EK9KEhwplKSnMkG2YtZQsFXBD8DBOE4aA0xSQlSSrKcoSog2dYDsbmwLXdhtn8NpzNUZpV/lqzZkpWrKVJUE3Qo2SUv3SNjxidXiq5q8iGYWYlQdg7NL7xIDE7BwNblYHWXm58I+MbdpFlC0KIJSCgkcQFKc+BUnxUmIYJXy0ITJqCA7hE78Mxy5BUdFObpVCNOYfiMpX4bqXKOxCkqJa1ix3uIuw0KWpcvJlWkDPKPfSoHRSdSUnorUXgb+K/E29lTbzH2IYagOhQBlruRx/UngoW8xsSA17JVK1SlS1nMqTMXJKj+LIzK8j6Qnw3DFe6kBF7OCw5sblnsmw56g6nDKRMmWEI2uSdSSXUonckkkw9RmSM2IZyf6xIK/vFOff1gUVRWcqD1VGMduRBAvCplQlG9+GvpE0YglwClSX0cW84jJpwm+p4xYtLhiHjFYnmaIEvKxEFhBIUQHDseEYPtf2arXM2iqZramSV+stR8e6T0O0fNUYzPTNapmT1JSSFozqQrRm2aHhCYouAZ+gZ1fLR7y0jqRCur7V0cu66iUOPeHGPz1XTgtRLqb9ayo+ZMEYBTypi1S1AFxts3GN7D5wd48p9mru1+GVEpcldVKKVpKT3uMfCaw98pPfykpCn1CSwI5HWI1FCuStUsoUQCcqgl3G0REqZtKmeUGAQLQGIJvNVTKbcseN26G0NcPkFRBKi3EhvmecDBRGYrlpsQ3dKXByucwsWBP9MNqZSPZKmJlglKmPeJBuAVAvcMX8GiWwnpFfyjOipEi7E8ztptpq+g2jRUqwhKczjMQANyekIqKpmlJyyylRBAZJstK/wAROgKcp3GrEw4oMCHvLJze0KnCtUgzAgEs75Zlzq+7AQxfSA7A/wC5l2Gz1TFJmmySnRvdUFOAC9yzvYXboG38KosETFICWLJbS7J0YDwcxUZQWAEhJT5P0szPHqQhOqVIzFyQdWDMS7tpDBxEM1zce0kpa0qIWlZSWyqCcz8XCbjyjydNQvuOnR1BQNht3SxJJB04dI8VMWhLJKFb2OvIB+gfnoNIMpJADrys4cgktxsHYF943Fk2F/a0pl4WShTTFAlNg9geFyekATK5Mgf5qwmzJTqfrFOKdrBdNOHLsV6jokb9dIzMxJWpS1OVHUku/KFs/lOhptFUcXrYHz/5GNV2nUX9nLYcVb9AIjI7TrT7yR1B+R8YUqGzn7uTAxLkAaHb5wskzqjRUCLbZsqXtRLIunRtNfKKu280T8Ln+yClOkMAC5yqGg1OkZcSyO8NmfyuPvjH0GlI9mkoHdKQw4Jg0F5xu0dFSpgbOs/M6ksWNjwjU/4dY/8AwtUkKLSprIXyP4VeBt4x9jxXAaeoH+dJQs/mIuOWYMYzR/wzoXJImMT7vtC3O+sOIuJxf8dwbrHWLSPZrKxYTAwPAuCQ+2YPGdnhN++pIJPdSkp8yA5842aaRBk+xU5ASEgkuWGhc79YU/y2lQcoQpR4d466WFhE6fhkw9Sr1gqkcdZlJiE3CEqdQIdT7hj3feV0aCJGCzVrzqQQkAAFViWAGYjV7PGold3/AEpAQ+5ZOujs52IgeoRNWP8AUyv+UX0JFy/TSNs9+kSulA5My1fVKVNUpRcg5Qdu7YebP4wJLxQienKSUtlNjbiRsr8IcXT3uJaKF28IDo1oUc7qGV1FLHKFZSlRBIvYmwPg8Sg5JnVKALabNKgpCgGBWCCW3IZzx0EZVS5kubnTZaVrWgKLBYmNnlk7Fwz8QeUK5s9c1SnSlWV7KKtixIILJDghyztHSpykgsCtIuqUsnMNHVKXroBY7D8Q0Mnd1iwvdia9GKyJyVAn2c1I70tfdVbbnyUL+oNVG4qqYg94KnJVzlhIN+QUoeKoDoaMzUJmSzmQQ6SQkkf7TmdJ14dI0WEUiZZK1M7APskP7o8bk7ngAAM55iJpZNw73iE3GJaLKWH5Xe9+UZnEMYBYAkIL6W036QCZ+ZQvbYNrz++ECaucTYpYzNJX4uVpygMDqHu3PhF2HVCtGZOt4QpmBLn3jzg6nmk3f6wveSbxm0AWmqk1TdBBSVBQcXjLYZVLWe82UaNxJ9TDunm7JsRtFF78yci3EOeEXaPspS1l5stJWAyVtccj+YcjDSfWZbAOr71jpNSDbQ8IIVNp5mzRLLutPkOM9lV0ym/hpak/hWkWPV9DyMCS5E4e6hCOjCPtsySlSSFAEHUHeM7VdlJLk5yhOwcW89opWqCMyU0j0nzRVLPOqwIj/L5n/sj6aOxEs6TlMXYsDoQ3oYynaHDf4acZWbMGBBZnBH1eGKwPEArbmWooJqEkrMspH4nI9C7+cX4XNKgDkUBzb6xdJw/2l5hzF7g8ubt5QXLl5S6FC3C/h0jnvW8hO4tP1juipSU91SX5k/SC5SEpLTXN7d0s3Fxbz5QrlCYQ4YAv0EeIq5o/E7WY3g1reYgdySeY+CpQQCkMnZh9N+UTp1E3y2PP5wg/mAIOdBD6lB+I/vDVFZKWUhKwSRobHhoYclQN1gPSZRmGTUj8pzAagRn+0PtJpTJTMyJZ1AAub2BbppDitmBGVN73tqS4AEVS6cGYVn3mAbUAjcc7+kGRfELTnuzv9pn5HZlf50pf9L/OPZvZmcPdyKHVj5G3rDyaqaCMiQRxJaAKTtOk2mDLdgQ7PwL3HjA7Vly6nVP4lsfv3mfq8MnywXlqy8QMzeTwrIvoeHTwj6gJoOhgerppax30pVzI+B2gTS8oyl2qww6+0wEtLpLvlLl+G2+usavsvOeQAWdJIF3tqPC5HhHisBllJKT7MD/kPEK+REIUSZktZsUqBCgxYXe42840fBmMrVaeppkA2tnM2jffx8IX1VPMzKmJIJykIBBtoxd76q6uAdHhX/FTf/YfTy0iCqmcC+YuL62fg2jfSB/yB5Tm9xfrGlVPmJEtKUEkgZiq7aC5SW5n5xUjEEqMxgppbAn9ROgGtrG7WIME0lamZYajUf8AYco9n0qFapGrg3BBZioEFwWtDwQwxElWXEAVXizKBcAgHVrsfQ+RgaZiYHvAjpBdXh4KisEhRBAsGFmDsyjxZ9zGVxHDpyAEoJOYkuGDHuhLg/hAdRa5PWNMsHYp5EhitPKWCqSoZrugHXiw2PhGco1ZJayQosWIID7BmDcfvSJ1MozFrTkICCzk6lzo1tADruNIT18yZLzAqJBDFy/TpEzLY4hrxa+JcicZa/aIIIuz2CgS5Qr8pdyCdHIMHKqZaxmQcq0m6TZSTtb14ani4OFy51S0uRLUsg95kggWF1KVYCws4djeHq+xlWlLqQm34UKCi3JxboH8YHYTkQWYcQvsZNb2yRZIWlSRsPaS0qUByBOnOHGPzGlhnuoAt0hVg8syknMLEvmG5YBi+nugeAgbEKxa1kGwdkp+ZgHbFppUzeRQrMS/up1bToOZgqXUkG/vH0EDmawCE7e8ef1+9o6mli+pFjCIUa0xKj3S7B30t5Q1E3KAwLnp5+kKKUB3NkpueXKDqeYcxfXZtn0DQxBbMBjfEJoJJQRrm1KvwkE7jTjDgV+WyWc6cfL7aM6vEQhSks5fY2fRrX12i9OaSjMbzVWBVolz7r6Dxa9oLd5Qkp35jaorcg0zKDZ2vlB3LXJiNGpTgBeZOqiRo92dy55C0A4bJK3WFlKsxBDdLlOgU24g+oqsoCEC50b18YAZlbOqCETsWKXSLkbnQdeMZbE8VDl5mdXUsOGmghlWyZqUEpUjMbMoFh5PfmYx0mSp1BaAlabEDS4L+d/ECDOJKLMSQJ9K7CTyZSkE6FwPi3LTzgnHezyaiYFnUJCfIk/OI9kMOSmnlrKe8RrfSw/6w/IiugSq3kGoCsxE+fZUhAQkAZTYNZtviYNljKjMGJGgfiRq/j5R5PpsgPdbz+LtEUYgCgpyu/QeUSBSTmdlQWHhE9QFLclV+uvO2n7RAVKA3eAd8ydj9f2ikLFnyeRLQNWUfdUtN0sSVDz01F9oYKRHMpSiCfFiFJxBF3Sp9gCD6taKppK05mSEmx4+J1/aKaeVlQVjKFJIbiLjQaQxk0ubvKJUTxhyqBxHFUp5EuwarSEEKUtTMRd2bg+g05Wh0lRcK3IDwpk0ATdILmzCHLDXkG8ocJztSV3XXrLSxFzFBppZ/CDzN+ovFC6xKSAp08MwIHgTaA6mpIJMskgs5KiRyyjSMvFJTf8ASXYvKcBCCUACxTrawHRx6QlnTKiSzKMwEXFu629+UMJc0ls3Bn48+RvHqFLKiANBdR2f70jRF8yum5pjaQCPX6yudiClyQCliqYwA1UEjN4XyiAqhaiolYvbppZvv4wXVLSlOSylCws7ElzpxZNjw8wSolV7vfq/Hh/aJqz4sJgK2wJdmGrX5Hnv6RFSbahujNziNhueEQmEXMTkXmhKp3dIbz0PNvveHmDZgghSVgvcqfvcGe/C0JKZClqBlpJIIJ4BiNToP3jVqPH5+AirTp1i6zYtFUkzDNnTCFZAyUIdszakAsLmwMeS56fZGdNSZQ0ZYY68NXMMFFy2+n9/CLVoSQUqAKW0IceUU2tE1KgNgR5ceQ+sz1dhyVJzJuCHBF3fTSM5J7HmpWPakokpLlj3ln8qb2HEt8LbWrmpLBgw2s3z+UXSyAl+W3LhA7AxiHqY2iTw2ilSEBEpCUSxolNm4nmTzvF6Jr3SxSzgu5HB0jaAJU/OoBBBSQxBBDOxDj/tzhjmKGtnIDG9217o3OkFfETxE2K4QpYUUpCVEGxLAnn9W84wxKnyzkZJqC1+J0I4jU6kcI+oLmBfeBsSX1Gwygtdne3WFOKYGmplsu0xHDVJ4h3dJ5uDE9SkGPh5hrV6T59OplJsNDvx4xZJXfpBU+TNp1eznBwdFN3Tw8eWojhTgEKGmpHDhfz8ojK9JRcEXlkyZdMsC5IbmefID16QWme68ySciN+PGFaV5F5gBnW4D7J3frp5wXLXnWJaQMgBUtuZ+eg5CCgBcw2jkEFc4JClaoTo5bifKJYdPmTivUOcqjlGXT8UtSsySNHGsAVNYrMooKhlYISkbjaYkh7nQ6NDv2zBwBmLAwMffaJKsqBIlsCTlT4ltB1MZpNYuYc5dLj3dGHCCKirE0kJLhKikn9W/wAY4UxEEOMRJa5zCcPUStNzrExSmdVKQgXUUp5d1LqJ5MoxZRIyJVMI0FhxJ0A5/WH/AGNoSjNOWO8oMnm5dShyJjAJm6wJmtp5QQlKE6JDDwibwhkVBkzEy+8twogqVr3nNy+ZQBa2zaQzk1iVJCk3BDgi7xYHUYnPsTzE1FjEmZoodD9Itm4XJWHAA5p+mkYZVCOY66f1J+YgmRPnyrhRI4+8P6hBX85cpKm6m0e1WALHuKCuR7p87/KFs0TZQUFyiygxbTz3gmj7VEf6iLcRf4aesPaPFpM33VDp+2vmI1t8pUmtqDDC8xkuvZOXLb71gmjxbKwILdB9Y0lfhMib+EA8U2/aEVV2dUm6FBXI2P0MDZhOlT1NCqLMLRthldnzHYB769PX4wwopjABduBfUbeMZGRUTJKnUkjiDoehgqfXSV6IY+V+oeDDxFXSbmxweozNTXJJScuVSdwf3hIqgb3c0vkCSPI/KAJFaU/j8GJEeVGKKL3D9P3vGbgZqnpqiYBhkyZlSPaKCRmueT2yjc6RTPrCTlSvKgOxTz57nnCaomlblZe320G0VSMoTbN96wisSRiNqafau7+pKWEgm9ti2v3eJzFEiztsfsxeAUpy90g7u3qddoqJ92WpbJbNYPuRfxBiexEnFiZ6SbOPP4cIHnhyANbDW2rbwQUjTMrKPn/aB5qQT3XYbn76GN3mwMzQYbSLlpKVFJDuGd3Ox4xfMLfvCqVjt2Ul+ej+cX/zCWotmynnbq5joIRbEQ1GoDciEJmga6qsPsc/lFWI1gloKjt98PpHTMrhYLsGDFxGU7UVpKkoFtz8Bt1jbGTHzlyK9ySo3N+NoYiXm9mpJdiHSdmU5Y7KfXyjIiaU2KglJdyQ42YHlrGgwic0tN9tDqHu3ONLnBiLWmopkhIZNg5PmXidTNBOYkhKXJUOQAHrC+nn84L7qwEquLaFt94Yy3XEEi8tMsk5kkBR/pWOCuB5xOSsKO6Vp2/EOX6hBXswRb7++MDVSX0BzjQ8Bvm2IhW20DrPK+gTNQUzAkg62Ydb6Rg67CJkoGYh1ycxctcMwHVOpf8AvG1m4k7JSlJVuW35R0pKlFpiiAeGnjCKrKxsMn76x6DbyZ8zqq4AoWkvldJcbHUepg9KfZyiAkEnvLTmKSEncM5t8jGxxrsqlYdKQVC6dtLs4sRyMYojOspUSlajkyklJSQ7EgHvjXmHvymZWT/aVUyrcQnBaVIGcoYn3VKurKeKnLjyMM5KSs8tvK8QmpCUsNAPSLaOsSmahBDpIIKtQlQOi293SxhZa02QWJMmjDm/DzLdLnnF0mi3Oh+MaFNODfbR/p5wJMlBRyJDJdlHi+oDdLnbTo1VvEEiBUFAJq0pJaWn/wCiNT8vEnhDytqfZzqeUlIaaVg8ghDuPQNHlHlCikD3bWBYW0NrFjAGIU6JS0qSvNOE0zUI3ZaGmSx1AUQ7XAiqmAAbj4yKuzkixhuMSsqpE/ZC2UeCZqcr+Csj8ng5FNlDJAAGwt1tAVVXEozICFSik5yt2AY5swswFn31DR5TGYUJInM4FgkkeBUXI5mMK02FziKDVFYgZiuZhG8tXn9RAcyjKC5SUn8ybfCxhfh+JTZZKUKKsvvS1Blp/wCO/VMP6LH5UwMruncH7t4w0EHidCxiuZTvqlK+Y7i/SxgCfRJfuqZX5V9xXgrQxqJ9IlVxZ+GkKqmnUAxAUno48toy0YqGKhX1Mg3Uei7/AP0LwdTdrBpMSU89R5j6RQEMO6opH5T3knwNx4QuqpSfxJy/qRdPiNo1xHKk1f8AMpa091QI8x48PGFFcmW9gx5fTSMtMkKzD2bkvYo1c8oY0Cp6FgzEuAxZXddvj6wBF5XSq91/tNAnBJ+RKksXDsbEcHeA59OpHvgpO4b6xoKbtRLIaYCgniLeY+ghjKq5U0WUlY8FDoWtB7B0gr2g9/EJhkgH75mBp7u4+7RtavA5My+UpPFNr9DC6Z2bUkgg50gglOhPIXaAKkS6nrqR6+8jT5vZZ5xS576iEgEJ2AYalx4lA4xOS+UrUEpKgFKfRCQBlHNkt5gamw+KVS3SDLUUBjMOUgE7D4ng5HCLcXeYkBIzArSVgEXSCtXd4gqyHoBzhey5v9/f/ZJ3RYgnAPyH3/EgK8lwAWyqUCWL5UlTFLd1wNiWcQvnAqVl2KQoJGxzrQoA8Hlk3exGsMky8iCpRABDqJ/Cl3u3NnbgAHJaB8PdWabdPtGTLB/DLQ4CjwKjnUeDK4wwIBHoFS7KP7+/29Z5PlMAGTmHFQHodPGAP4dRURprlL6jYgvfaLZU5ayFIJSglpaXyuNlr/MTq2gEFYf/AK0rLoqe6R+kJmFVuGUyvEJ4QRjDuQG/l9/f6xonDTJkhOqtVHn4cNPCMFjNUPbEcGD7Pw24iPpuOVaZcpS1aJGnE7C4a5aPli0PmK75rnkdbRt8cTgPVJyeTOoZpMxQcM7kN98obonsesZ2grUiYpOZ7afP1hyS4+EArZvNHIj+mqnEHUValWnxjK0tY0GYUMpUX94uIoViCIsibGRUcCYrqcQI7iSbwkn4nkDAOo2H1Me003clzxhVep+Qcn9pgsMmOKKUAL6n7tBKZjWVpsYVorA7XJ2A1g4084pzEAD8o18YUqgCwijcm5jKmqFI/Unh9IjX4TKqP8xDCY3vD4KG8L6Sqa20HIJHeQWgsEWPEG5U3EyGNYdPb2YSoKUq6ksSkC6SAfeD2gnA6JUp1TClKj7xfKT/AMf7xpcSqwtGVSSFcRt0Ihbh+GIU7MV29468fpEz0RfBlSV7ixhhK1g5bnmWJ5DgPWDJdEpMtN7hnYN13OgPHaLaehye6zPofkddeLxbNRYguAQ2rM4hoWw8UUz5sOIOvNLU4IyrN3GhCWd9LhIHhHlWZRIBbOq6C/ecDUW2fg0Vz5h7pU7D3u8z7Dfc8eURq0NLC0o78sOgaHmLA6jZm0gN3t6wwouL/pj5fx8J7SU61+0K8rTE5VJAKeIL3KSbkOOT6CFi6eZLCJa581BQkJGROYKCSQlZIBYkMCOIhh/MGLlQKbBTJIUgqukKHA6aa+ivGMQly5pCkm4CtxrwAWN321eM72wvNrpe8e1vbESzMRSsMunSbNmBOZnt3lX34wMqnK7peY3FkzUjkoWWOsUFXO0GYVOyzEnjY+MSJXcGd+ppKe0lRmVUddNlk5FZgNUkMof7kH4iGlNj0tYuWPp+3jBGJ4WiczuFA2Umyh4xmsewibJZSgZiT+NIZY/3Ae9F6VrjM5wUBgI7rVIIfjuN/rCsUk5bmWgrA1axH18PKK8PoioZkTBNQNQmyknmg6Rr8HrpIQEhktrzPE8D1hoW8a1emEwMzPYNhksnMXz8A6VJ6jY+EO1pUAxKZo4Lsf6t4ZVNBLmgFSXOyge8OYUITV2GVEsPLUJyeCrK/qGvrBcRGKrXv7/X+oBVy5J7qxMkKNnIdPhC5fZ6YDnkqChsqWrKfQtDGRiKR3FgoUdUrHd9bfAwSaRAOZihXGWT6p+hjXMYUKYiqRjNXJPfVmA2mpY/1DXxhrRdsk39rLUjmO8n0uIvea1wieODZVeI/YwBMpaaZ+aSvnYdOHwjeYBAPImlosWkzR/lrSriHvf9JvEavC0LuFFJ4pAY9UqBDxkKns0sMUZV7uCx8xvAwrquTYLWBwmDOnzjL+YmKCpuhmjruzBX/wCdSm0CwGB4skAeJBMQqZC0S8swOClSSpN7ELBILWLTDrbSA6XtjMdlygrnLPrlMNaLtNTTFAFeTksZfXSMAXpG/wCTVtZ8gffSJ5SZYLpJWohglIzlvygDR93YdI0GB4WpBM6aGWU5UIBf2aXcuRqtRuSOQh5TzEEZkkEcQxHmIprpgylTgtoLFztGbbZMTV1hcbQLX5mE7eV6ipMpPup7yrsSo6DTYfHlGDrZ6wCAlSn8hG9rcMzEqVcnWMxjVOUXCX4tEzMb3iggbEwVSmYFZ7gi4baNR2f7QZ2RM9/b9XTnyjxdIFpcaRncTojLUCLfIiMBgFbHE+kIYxaueEDMfCMVg3aFXdQshwdT+LkeBhzU1efRw20GHtAaM6CbmUpatoa0a1LOVOp32HMxnBMyoA4n7+UafCO4kfmNz9IXS8bEmAw4E02GUyJYtdR1UdTDaVOhBT1EWLxdCN3L6CLBYCLMMxVCUsoWJMVyJxEKMRxb2jBmAOsMMIBKb+sIY3bEG0aCUFa+UTl0QBfQ7NrBEmSGd25xJdUlAuL/ABhoQQMyJUsXJLDW0B1WK5rIll9io5fMa6x5U1K17twAsD4xZJWWZQtz1hboSPCZRT2/mF4qk42sKKZksc2P1cEQdKx2UWfMnqPo8TxDCRMGZLBYuk8eR+EZpLanV/u0RMXp4M6VOhp64uosetpsKeoQv3VBXS8C4lIk5h7VBKmt3VGzngOLxmpiCLi17ERYMUnC3tFHqx+Igl1A/MII7OIN0b+IgMtru/3vBmGHMc2UlvjE8Mw9U0uq0vyKunAQ9TVypYYOydcqSQG1cgNaJAhMu1GsCeEZMjJ9oT7rDd4umgKa7tByYza6xaFKSQCASL29YapIxJUPeXbi0GqsEC5xmy1KlrAAC0WvzGhgapnTUWqpZWNp8iyxzUneGKscQPeSv/iQR6tDKlnomy3SpgfzJ+kUoKiCTtq6DttvmJcPq5yB7STME+VuUe8P96OPSHuG4+iYO93Txe31H3eFlR2dGYzJRMqZ+ZBYE8FDQwtrKgJOWsQEq2nyNua0jSKErA8wioPHymzqaSXOTduKVBnDbg7wkrMIqQc0tSCBokBio7lQLjbZtTAcibOlgLlLE6XrmRf+pMOcP7RIXZVjxHzGo9YZtBPrCSoycZHrmLVzCC60kj9IuNPeTqDxZ4vRUiYPwqAsxFxy/MmGtRRSp3fcudVIUxPAEix8YR4n2UzELRMUpQ0zqLgcEq2jDcdI5DSfk2+GJIUiXeWtco8i6fHfzeLPbTxqlE5PEa+LfSBPZzEsnMcwA7qxmuw0UO8xIN768miz+Iyge1Hsx+Z3D7MbH0jd5o0jK1S6aYe9LVKO5ZmPh84I/wD5NKg8qa6ebKEOKZGYAEBSf1B/I6iLlU8sXDo5pP2YwiSvUN7CIP5MuQklLoAuShTeLQxolLUgZllb3DgadRrA06tWsrRmJSxCSdy1niOF1BEpIB0FnGnCJWrjdYcQ+4Ypc8w6ZKCrH0jJdqcHWpJyk6g2LOwNjxEanD5yWUMraFXB2Gn0EdWKSx7oNj09YEkMsFQ1KpgT5vhNGfYuRqSfP9oX4xQ5kKG+o6iNkFpmKUnKxGn1ELq2jbaNIQRN1wRUJItPlcxEM8NxU2Ss9FfI/WPcWpck1SWs7+d4VzJUbBvgzKtLFxN5JVmmITwD/flD0VISHJYCPntLiw7uYsRYn5w4qcQK0BJA4vxjKR2ixkjGxm5o8TQQ+cN1hZISVlRSXDln3jKSVd4AbxqsPVlYCG7t0WY0wqmJLqFhxjUyJoSHPlxjPSaxKE5leAguTWWC16n3U/OGILQDHk2uIDkdBw5mIJm+0F7njCujqlKJsSDq+0NadQAYQwZg2hlOlgxirEcQlyk5lqAaFGPdo0SAEjvTFe6kfGMxMlrnq71yduEbJAmFrTV9n+0qZ80oluw1cR5j9N7OZn/Cu/Q/iHz84s7L4GiSSsakNDTGab2kohrp7w6j6h4krLvUy7SVdlQHocGZKYvnrFZWN/n9I8PCKzLUY5mZ6IAdYw7Kz80m5uDFiaMhSiMiE5jdVyxu6SokDvbNtHkdFZHjtPMUz+GDHNESUJchRa5Gh5iM12gltONixSD06iOjoOkLPFao3pRPUrswYHcEi0W06lJysS+hINh4iOjosE418xhIxeaCkApVxLB/TX4x4rGDdJSklRs+jvwctHR0aKKeRGDU1UHhY+8ztTRTJK/aU0wylG7fhPIp0giV2olqITXSfZL/APdL0PMtHR0Ze2I2hq6qva8eyRMSn2kiYJyPzIPe8Rv6wdRdozYLDnlY+INj6R0dDDg2noEO5bmO5EuRPHeCVEaBXvJ+Yi+RgshCs6ZSc2yj3iOhLtHR0ZYHMS9R1O0MbRH2vxwyU5Ef6qxb9I/NwPKENNjU6YAmYpx016kffSOjo5teq28i+J2NNp6ZpAkZjuQARZj0MW0soJDa67R0dADoYip4SVhSQBezxJaO67PuTpHR0NGRJmFrTMUdOTOClJCS7BtOeUQxrsKUY8jozTi4MzXuQy28phe0eG5ZgtcpN/G3zjJVVKwUWYbemnGOjo1/6WhO5XT7/SB0tOFJKtwYtpMQ9mrIq6fUWew4R0dDFyxE5pYlQZoaVSQQrY8PjDqnmgBybCOjoJZqXUc/OrOr3RoPhB0uoKlObK2GzcI6Ohy8XgmPaJZFyzmPMWxdMlPvDMdBv5R0dDWO1bwDM3SUa1zDNmakMkHYfvGowumyAqI0DnlHkdC2wpM3RUO4U9THGBz1HMS7G45DhDZSjwjo6JaBJS5nQ1YC1SAJlaqjCVqA2NvEPeBDKeOjolqABiJ1KdRigJ9P2n//2Q==',  
    ),
    BlogPost(
      title: 'Dirham',
      summary: 'Desert Gold: The Rise of the Emirati Dirham',
      content: '''The history of the Dirham is deeply rooted in the rich exchanges of ancient civilizations.
The term "Dirham" traces its origins to the Greek coin 'Drachma', which was widely circulated throughout the Mediterranean world.
As trade routes expanded from Europe into the Middle East during the classical era, the concept of coinage — and the name itself — traveled along with merchants, influencing early Arab economies.

By the 7th century, during the rise of the Islamic Caliphate, the Dirham had been fully adopted by the Muslim world.
Caliphates minted silver Dirhams that carried religious inscriptions and became crucial instruments of commerce.
The Dirham thus evolved from a Greek idea into an Islamic symbol of economic and cultural unity across a vast empire stretching from Spain to Central Asia.

Dirham in the Islamic Golden Age: Economic Backbone of a Civilization
The Dirham played a pivotal role during the Islamic Golden Age (8th–13th centuries), a time when Muslim societies led the world in trade, science, medicine, and the arts.
Markets across Baghdad, Cairo, Damascus, and Cordoba depended on the Dirham for transactions large and small.
It wasn't just a medium of exchange — it became a trusted symbol of value for scholars, travelers, and merchants alike.

Inscriptions on Dirhams were often minimalist, focusing on Quranic verses rather than rulers' images, which reflected Islamic values.
These coins were crucial to financing monumental projects like libraries, universities, and sprawling trade networks linking Europe, Africa, and Asia.

The Dirham's Role in International Trade Networks
The influence of the Dirham wasn’t confined to Islamic territories alone.
Due to the expansive trading networks, Dirham coins have been found in places as far-flung as Russia, Scandinavia, and China.
Viking explorers, for example, prized silver Dirhams and often used them as raw material for jewelry and trade.

The Dirham's acceptance on the Silk Road and throughout the Indian Ocean trade routes showcases its incredible importance in connecting civilizations.
It became a unifying financial instrument in a time when no centralized global economy existed.

Colonial Influences and Shifting Currencies in the Gulf
Fast forward several centuries: by the 19th and early 20th centuries, the Arabian Peninsula was experiencing massive changes.
European colonial powers, especially the British, dominated the region’s trade and political structures.
As a result, currencies like the Indian Rupee and the Gulf Rupee (a special version issued for Gulf countries) replaced traditional coinage systems, including the Dirham.

The indigenous currencies faded as the Gulf economies became more dependent on colonial trade networks.
However, the memory and legacy of the Dirham remained alive, symbolizing a proud heritage that awaited revival.

Revival of the Dirham: Formation of the Modern UAE Currency
The opportunity to revive a native currency came after the formation of the United Arab Emirates on December 2, 1971.
After a brief period of using the Qatari and Dubai Riyal, the UAE officially introduced the United Arab Emirates Dirham (AED) on May 19, 1973.

This marked a significant moment — not just an economic move, but a cultural assertion of independence, unity, and national pride.
The UAE Central Bank took charge of issuing and regulating the Dirham, designing it to reflect the country's rich history, traditions, and modern aspirations.

Design and Features of the UAE Dirham
The design of the Dirham reflects both tradition and progress:

Coins depict cultural symbols like the Dallah (traditional coffee pot), oil rigs, and dhows (traditional sailing vessels).

Banknotes feature stunning illustrations of UAE landmarks: mosques, forts, and modern skyscrapers.

All Dirhams have inscriptions in Arabic on the front and English on the back, symbolizing the UAE’s global openness.

Modern Dirhams have advanced security features, including watermarks, holographic strips, color-shifting ink, and micro-printing.

Dirham coins and notes are available in multiple denominations, serving both daily needs and large transactions in one of the world’s fastest-growing economies.

Economic Stability: Pegged to the US Dollar
Since 1997, the Dirham has been pegged to the US Dollar at a fixed rate of 1 USD = 3.6725 AED.
This peg brings remarkable financial stability to the UAE’s economy, boosting investor confidence and enabling predictable international trade.

The Dirham’s fixed value supports major sectors such as oil exports, real estate, aviation, and global tourism, establishing the UAE as a premier business hub.

The Dirham’s Global Impact
Today, the Dirham is widely recognized and respected around the world.
From luxury shopping in Dubai’s malls to international real estate deals, the Dirham facilitates billions of dollars in global transactions each year.
Moreover, millions of expatriates working in the UAE remit billions of Dirhams back home annually, making it one of the top remitted currencies worldwide.

Whether in a bustling souk or in a high-tech financial center, the Dirham remains at the heart of the UAE’s economic miracle.

Timeline Highlights
6th century BC — Greek Drachma emerges.

7th century AD — Islamic Dirham introduced.

8th-13th centuries — Dirham flourishes during Islamic Golden Age.

19th-20th centuries — Gulf Rupee replaces local coinage.

1971 — UAE founded.

1973 — Modern UAE Dirham launched.

1997 — Dirham officially pegged to US Dollar.

Fascinating Facts About the Dirham
Ancient Dirhams were so trusted that even Viking warriors hoarded them in their treasure troves.

The name "Dirham" survived for centuries even during periods when it wasn't officially used.

Modern Dirham coins are made from a cupronickel alloy, making them resistant to corrosion from the Gulf's humid climate.

The UAE Dirham features no images of political leaders, respecting Islamic traditions about human depictions.

A Currency That Embodies Legacy and Ambition
The Dirham is much more than a monetary tool.
It represents a rich tapestry of civilizations, a journey through ancient empires, colonial struggles, and the bold vision of a modern nation.
As the UAE continues to lead in innovation, space exploration, and global finance, the Dirham remains a proud emblem of resilience, unity, and boundless ambition.
It carries within it not only the history of trade and empire but also the dreams of a future yet to be written.''',
      imageUrl: 'https://media.istockphoto.com/id/1211295986/photo/united-arab-emirates-money-a-business-background.jpg?b=1&s=612x612&w=0&k=20&c=VoIGTbGvHGo3K0sUZhp3BT8GZEu_HB-ZwbL6g7b3--w=',
  
    ),
    BlogPost(
      title: 'Dinar',
      summary: 'Oil and the Dinar: Wealth, War, and Worth',
      content: '''A Symbol of Wealth and Prestige
The Dinar is more than just a currency; it represents centuries of wealth, authority, and cultural pride.
From ancient Islamic caliphates to modern oil-rich nations, the Dinar has maintained a prestigious place in the world economy.
It stands today as a living reminder of the golden ages of civilization, trade, and financial innovation.

The Historical Genesis of the Dinar: From Rome to Islam
The story of the Dinar begins with the Roman Denarius, a silver coin circulated across the Roman Empire.
As Islam spread across Arabia and beyond, the need for an independent and dignified Islamic currency arose.

In 696 AD, under the leadership of Caliph Abd al-Malik ibn Marwan, the first pure gold Islamic Dinar was minted.
This marked a revolutionary moment — a currency not bearing images of emperors, but instead inscribed with Quranic verses and Islamic declarations, emphasizing faith and sovereignty.

Key Highlights of the Early Dinar:

1) Weight: ~4.25 grams of pure gold
2) Circular shape with Arabic inscriptions

No images of humans or animals (reflecting Islamic principles)

This Islamic Dinar set a new standard of purity, faith, and economy.

How the Dinar Fueled the Expansion of Islamic Trade Networks
The Dinar was not just a local currency — it was the backbone of a massive trading empire.

During the Islamic Golden Age, merchants, travelers, and scholars used Dinars to facilitate trade across:

The Silk Road (linking China to the Middle East)

The Indian Ocean routes (connecting India, East Africa, and Arabia)

The Trans-Saharan routes (trading gold, salt, and goods across Africa)

Its purity made it trusted beyond Muslim lands — even Viking merchants in Scandinavia and traders in China accepted the Dinar as a reliable medium of exchange.

The Dinar's Deep Religious and Political Importance
In Islamic tradition, wealth had to meet ethical and moral standards — and the Dinar fit perfectly.

Religious Significance:

The Dinar was often mentioned in the context of Zakat (charity obligations).

It symbolized halal earnings — clean, pure, and just wealth.

Political Symbolism:

Minting the Dinar showed sovereign independence from foreign empires.

It reflected a ruler’s legitimacy and control over economic matters.

Every Dinar carried not just financial value but religious, political, and cultural pride.

The Global Footprint of the Dinar in Ancient Economies
Due to its consistency and high gold content, the Dinar spread far and wide:

1) Found buried in Viking hoards in Northern Europe.
2) Used in Byzantine markets alongside other coins.
3) Circulated through Chinese bazaars via the Silk Road.

The Dinar became a true global currency of its time — centuries before modern globalization.

Challenges and Decline: Why the Classical Dinar Faded
Despite its dominance, the Dinar’s influence declined due to:

1) Political fragmentation of Islamic empires
2) Mongol invasions disrupting trade routes

Rise of European colonial currencies (like the Spanish Real and British Pound)

By the late Middle Ages, silver and other base metals began replacing gold coins in many economies.

Still, the Dinar’s legacy remained engraved in history and memory.

🇯🇴 Modern Resurrection: Nations that Embrace the Dinar Today
Several countries proudly carry the Dinar legacy:


Country	Currency Name	Interesting Fact
1) Jordan	Jordanian Dinar (JOD)	Pegged strongly to the US dollar
2) Kuwait	Kuwaiti Dinar (KWD)	World's most valuable currency
3) Iraq	Iraqi Dinar (IQD)	Rebuilding post-conflict economy
4) Bahrain	Bahraini Dinar (BHD)	Oil-backed strong currency
5) Algeria	Algerian Dinar (DZD)	Introduced after independence
6) Libya	Libyan Dinar (LYD)	Stabilized after political turmoil
Tunisia	Tunisian Dinar (TND)	Symbol of post-colonial freedom
Each modern Dinar represents not just economic policy but national identity and pride.

The Kuwaiti Dinar: World's Strongest Currency
Among all Dinars, the Kuwaiti Dinar (KWD) stands at the top:

.) 1 KWD ≈ 3.25 USD (highest exchange rate globally)

.) Supported by vast oil reserves

.) Strong, stable monetary policies

.) Limited inflation compared to other economies

The Kuwaiti Dinar shows how strong governance can make ancient legacies thrive in the modern world.

Art and Culture on Dinar Banknotes and Coins
Modern Dinar banknotes and coins are more than just money — they are cultural artifacts.

Common design features:

1) Historic monuments (like Petra, ancient cities)
2) Calligraphy and Islamic art
3) Portraits of national heroes and kings
4) Native wildlife and flora

Through these designs, every Dinar connects citizens to their history and culture daily.

The Economic Power of the Dinar in Today's World
.) Today, the Dinar plays a crucial role in:

1) Oil trade agreements (Kuwait, Iraq, Bahrain)
2)Tourism sectors (Tunisia, Jordan)
3) Regional investments and banking

Despite facing challenges like regional conflicts and economic pressures, Dinar economies have shown remarkable resilience, adapting to global market changes while preserving their historical identity.

.) Interesting Facts About the Dinar You Might Not Know
.) The first Islamic Dinar had no images — only Quranic text.
.) Kuwaiti Dinar is over 3x stronger than USD.

Ancient Dinars are now sold at auctions for thousands of dollars.

Some Islamic scholars today advocate for the return of the Gold Dinar in modern Islamic banking.

Dinar — A Timeless Legacy of Faith, Trade, and Power
The Dinar is a living story of the Islamic world's glorious past and hopeful future.
From the gold coins of Damascus to the shining banks of Kuwait City, the Dinar symbolizes resilience, pride, sovereignty, and excellence.

It remains a beacon of cultural identity and financial strength — a testament that great legacies never fade, they evolve .''',
      imageUrl: 'https://images.pexels.com/photos/10920552/pexels-photo-10920552.jpeg?auto=compress&cs=tinysrgb&w=400',
    ),
  ];
  
  get subtitleFontSize => null;
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 20, 55),
      drawer: _buildDrawer(context),
      appBar: AppBar(
  backgroundColor: const Color.fromARGB(255, 18, 6, 29),
  iconTheme: const IconThemeData(color: Colors.white),
  title: Row(
    children: [
      Image.asset('assets/logo.png', height: 40),
      const SizedBox(width: 10),
       const Text(
      'Currency App',
      style: TextStyle(color: Colors.white),
    ),
      // Expanded(
      //   child: Text(
      //     post.title,
      //     style: const TextStyle(color: Colors.white, fontSize: 18),
      //     overflow: TextOverflow.ellipsis,
      //   ),
      // ),
    ],
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.account_circle, color: Colors.white),
      onPressed: () {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          _showProfileDialog(context, user); // Show profile if logged in
        } else {
          Navigator.pushNamed(context, EmailPasswordLogin.routeName); // Go to login
        }
      },
    ),
    PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.white),
      onSelected: (value) async {
        if (value == 'signout') {
          await context.read<FirebaseAuthMethods>().signOut(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const EmailPasswordLogin()),
            (route) => false,
          );
        } else if (value == 'delete') {
          await context.read<FirebaseAuthMethods>().deleteAccount(context);
        } else if (value == 'signup') {
          Navigator.pushNamed(context, EmailPasswordSignup.routeName);
        } else if (value == 'login') {
          Navigator.pushNamed(context, EmailPasswordLogin.routeName);
        }
      },
      itemBuilder: (context) {
        final user = FirebaseAuth.instance.currentUser;

        if (user == null) {
          return [
            const PopupMenuItem(value: 'signup', child: Text('Sign Up')),
            const PopupMenuItem(value: 'login', child: Text('Login')),
          ];
        } else {
          return const [
            PopupMenuItem(value: 'signout', child: Text('Sign Out')),
            PopupMenuItem(value: 'delete', child: Text('Delete Account')),
          ];
        }
      },
    ),
  ],
),
body: LayoutBuilder(
        builder: (context, constraints) {
           int crossAxisCount;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 4; // For very wide desktops
          } else if (constraints.maxWidth > 900) {
            crossAxisCount = 3; // For standard desktops/large tablets
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 1; // For smaller tablets/larger phones
          } else {
            crossAxisCount = 1; // For phones
          }

          final horizontalPadding = constraints.maxWidth * 0.05;
          final verticalPadding = constraints.maxWidth * 0.02;
       late double titleFontSize;
          late double cardHorizontalPadding;
          late double cardVerticalPadding;
          late double messageFontSize;
          late double spacingBetween;


          if (constraints.maxWidth > 1200) {
            titleFontSize = constraints.maxWidth * 0.04;
            cardHorizontalPadding = constraints.maxWidth * 0.01;
            cardVerticalPadding = constraints.maxWidth * 0.010;
            // emailFontSize = constraints.maxWidth * 0.017;
            messageFontSize = constraints.maxWidth * 0.01;
            spacingBetween = constraints.maxWidth * 0.01;
          } else if (constraints.maxWidth > 900) {
            titleFontSize = constraints.maxWidth * 0.02;
            cardHorizontalPadding = constraints.maxWidth * 0.01;
            cardVerticalPadding = constraints.maxWidth * 0.010;
            // emailFontSize = constraints.maxWidth * 0.02;
            messageFontSize = constraints.maxWidth * 0.02;
            spacingBetween = constraints.maxWidth * 0.01;
          } else if (constraints.maxWidth > 600) {
            titleFontSize = constraints.maxWidth * 0.04;
            cardHorizontalPadding = constraints.maxWidth * 0.02;
            cardVerticalPadding = constraints.maxWidth * 0.015;
            // emailFontSize = constraints.maxWidth * 0.04;
            messageFontSize = constraints.maxWidth * 0.03;
            spacingBetween = constraints.maxWidth * 0.01;
          } else {
            titleFontSize = constraints.maxWidth * 0.04;
            cardHorizontalPadding = constraints.maxWidth * 0.02;
            cardVerticalPadding = constraints.maxWidth * 0.015;
            // emailFontSize = constraints.maxWidth * 0.05;
            messageFontSize = constraints.maxWidth * 0.04;
            spacingBetween = constraints.maxWidth * 0.01;
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Latest Blogs',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explore the world of currencies with insightful articles.\nStay updated with trends and news.',
                    style: TextStyle(
                      fontSize: subtitleFontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blogPosts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return BlogCard(post: blogPosts[index]);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1, color: Color.fromARGB(59, 243, 239, 239)),
                  const CustomFooter(),
                ],
              ),
            ),
          );

          
        },
      
    ),
    );
    
  }

  void _showProfileDialog(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Profile Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (user.email != null) Text('Email: ${user.email}'),
              if (!user.emailVerified)
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .sendEmailVerification(context);
                  },
                  child: const Text('Verify Email'),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 18, 6, 29),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 44, 1, 49),
                  Color.fromARGB(99, 89, 2, 97),
                ],
              ),
            ),
            child: Text('Menu',
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const home.HomeScreen()),
              );
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title:
                const Text('Settings', style: TextStyle(color: Colors.white)),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            children: [
              _buildDrawerItem(
                context: context,
                icon: Icons.notifications_active,
                text: 'Rate Alerts',
                screen: const RateAlertsScreen(),
              ),
              _buildDrawerItem(
                context: context,
                icon: Icons.trending_up,
                text: 'Currency News',
                screen: const CurrencyNewsScreen(),
              ),
              _buildDrawerItem(
                context: context,
                icon: Icons.support_agent,
                text: 'Help Center',
                screen: const HelpCenterScreen(),
              ),
              if (user != null)
                _buildDrawerItem(
                  context: context,
                  icon: Icons.history,
                  text: 'Conversion History',
                  screen: const ConversionHistoryScreen(),
                ),
              if (user != null)
                _buildDrawerItem(
                  context: context,
                  icon: Icons.currency_exchange,
                  text: 'Default Currency',
                  screen: const DefaultCurrencyScreen(),
                ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.white),
            title: const Text('Blog', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlogScreen(
                  post: BlogScreen.blogPosts[0], 
                ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: Colors.white),
            title: const Text('Testimonial',
                style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TestimonialPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.white),
            title: const Text('Contact', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ContactPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String text,
    required Widget screen,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(text, style: const TextStyle(color: Colors.white)),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => screen),
        );
      },
      
    );
    
  }
  
}

