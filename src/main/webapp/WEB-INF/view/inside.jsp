<%--
    Страница "Как сделан магазин".
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="s" uri="http://www.springframework.org/tags" %>

<h1>Как работает магазин</h1>

<p>Эта страница объединяет общие сведения о реализации приложения.
	О деталях реализации отдельных страниц можно узнать больше, кликнув по расположенным на них кнопкам
	<button type="button" class="btn btn-danger btn-xs">Как это работает?</button>
	.
</p>

<%--
<h2>Содержание</h2>

<ul class="discharged list-unstyled">
    <li><a href="#tech">Применённые технологии</a></li>
    <li><a href="#func">Функционал магазина</a></li>
    <li><a href="#checkout">Оформление заказа</a></li>
    <li><a href="#rest">Веб-слой в стиле REST</a></li>
    <li><a href="#forms">Проверка форм</a></li>
    <li><a href="#db">Модель базы данных</a></li>
    <li><a href="#customization">Пользовательские классы Spring</a></li>
</ul>
--%>

<a name="tech"></a>
<h2>Технологии</h2>

<ul class="discharged">
	<li>сервлет: Spring MVC, JavaServer Pages, Arache Tiles</li>
	<li>авторизация пользователей: Spring Security</li>
	<li>доступ к данным: Hibernate, Spring Data JPA</li>
	<li>веб-служба в стиле REST</li>
	<li>тесты: Spring Test, JUnit, Hamcrest, JSONPath;</li>
	<li>веб-интерфейс: jQuery, jQuery Validate Plugin, Bootstrap</li>
	<li>база данных: PostgreSQL</li>
	<li>контейнер сервлетов: Apache Tomcat</li>
</ul>
<p>Исходные коды приложения доступны <a href="https://github.com/aleksey-lukyanets/market">на GitHub</a>.</p>


<a name="func"></a>
<h2>Функционал магазина</h2>

<ol class="discharged">
	<li>Наглядное представление ассортимента товаров</li>
	<li>Корзина покупателя
		<ul>
			<li>выбор товаров: добавление, удаление, изменение количества</li>
			<li>просмотр содержимого корзины</li>
			<li>оформление заказа</li>
			<li>хранение корзины зарегистрированного покупателя в базе данных</li>
		</ul>
	</li>
	<li>Панель управления магазином
		<ul>
			<li>товары и категории: добавление, редактирование, удаление</li>
			<li>просмотр информации о размещённых заказах</li>
			<li>управление наличием товаров на складе</li>
			<li>перевод заказов из состояния "в исполнении" в состояние "исполнен"</li>
		</ul>
	</li>
	<li>Безопасный доступ к приложению
		<ul>
			<li>регистрация и авторизация пользователей</li>
			<li>ограничение доступа к панели управления</li>
		</ul>
	</li>
	<li>Двойная проверка содержимого форм: на стороне клиента и на стороне сервера</li>
</ol>


<a name="ckeckout"></a>
<h2>Оформление заказа</h2>

<p>Ниже приведена диаграмма процесса оформления заказа, на которую нанесены
	элементы данных и доступные покупателю действия.</p>
<br>
<center>
	<a href="<c:out value="${pageContext.request.contextPath}${initParam.imagesPath}"/>checkout-flow.png">
		<img src="<c:out value="${pageContext.request.contextPath}${initParam.imagesPath}"/>checkout-flow.png"
			 alt="процесс оформления заказа"/>
	</a>
</center>
<br>


<a name="rest"></a>
<h2>Веб-служба REST</h2>

<p>Помимо гипертекстового интерфейса магазин представляет веб-службу, через которую
	доступен функционал магазина. Описание веб-службы находится на странице
	<a href="<c:url value='/rest-api' />">REST API</a>.</p>


<a name="web"></a>
<h2>Сортировка, фильтрация, разбивка на страницы</h2>

<p>Приложение предоставляет возможность просматривать ресурсы удобным пользователю способом.
	Не нарушая принципов стиля REST, критерии передаются в параметрах URI. Например,
	в панели управления магазином так выглядит запрос отображения таблицы всех имеющихся
	в наличии товаров, с сортировкой по возрастанию цены и 5 товаров на странице:
	<code><b>/admin/storage</b> ? available=true &amp; direct=asc &amp; size=5</code>
	(без пробелов).</p>
<p>Операции сортировки, фильтрации и постраничного отображения выделены в отдельную
	иерархию классов в пакете <code>market.sorting</code>, которая объединяет
	методы изменения значений опций, формирования запроса к БД (<code>PageRequest</code>
	Spring Data) и добавления всех необходимых данных к модели <code>Model</code> Spring MVC.
	Благодаря такому решению контроллер формирует постраничное отображение данных вызовом
	двух методов: обновление фильтра и запрос на подготовку модели.</p>


<a name="forms"></a>
<h2>Валидация форм</h2>

<p>Проверка данных всех форм пользовательского и административного интерфейса выполняется
	дважды: на стороне пользователя и на стороне сервера.</p>
<ul class="discharged">
	<li>Проверка на стороне пользователя осуществляется с использованием jQuery Validate Plugin,
		который проверяет данные в момент ввода средствами JavaSript. Для посимвольной проверки строки применены
		регулярные выражения (regex). Визуализация дополнена классами Bootstrap.
	</li>
	<li>Проверка на стороне сервера выполняется с использованием пакетов <code>javax.validation</code> и
		<code>org.springframework.validation</code>.
	</li>
</ul>
<p>Такой подход к валидации форм делает процесс проверки данных комфортным
	для пользователя и вместе с тем гарантирует выполнение проверки при отключённом
	JavaScript в браузере пользователя.</p>


<a name="exceptions"></a>
<h2>Обработка исключений</h2>

<p>В приложении реализована централизованная обработка исключений классом
	<code>market.controller.SpringExceptionHandler</code> с аннотацией
	<code>@ControllerAdvice</code>, предоставленной Spring.</p>
<p>Помимо объединения обработчиков в единый класс, такой подход позволяет
	вынести проверку авторизации клиентов веб-сервиса из реализации контроллеров:
	права пользователя проверяются перехватчиком
	<code>market.interceptor.RestUserCheckInterceptor</code> и в случае неудачной
	аутентификации исключение <code>RestNotAuthenticatedException</code> передаётся
	обработчику в обход контроллеров, с последующим возвратом клиенту HTTP-состояния
	<code>401 Unauthorized</code> (вместо перенаправления на страницу входа, как в случае
	гипертекстового интерфейса магазина). При удачной аутентификации запрос
	передаётся соответствующему контроллеру.</p>


<a name="db"></a>
<h2>Модель базы данных</h2>

<p>База данных приложения состоит из 13 связанных таблиц, отображаемых средствами Hibernate в 14 классов.</p>

<center>
	<a href="<c:out value="${pageContext.request.contextPath}${initParam.imagesPath}"/>database-model.png">
		<img src="<c:out value="${pageContext.request.contextPath}${initParam.imagesPath}"/>database-model.png"
			 width="500" alt="схема базы данных"/>
	</a>
</center>
<br>
<p>Слой доступа к данным на первоначальном этапе разработки был представлен классами DAO,
	а с введением функций разбивки на страницы и сортировки реализован
	с помощью репозитория Spring Data JPA.</p>


<a name="customization"></a>
<h2>Пользовательские классы Spring</h2>

<p>Функционал Spring MVC и Spring Security расширен следующими классами:</p>
<ul class="discharged">
	<li><code>UserDetailsServiceImpl</code> реализует интерфейс <code>UserDetailsService</code>
		и обеспечивает извлечение профиля пользователя из базы данных;
	</li>
	<li><code>CustomAuthenticationSuccessHandler</code> реализует интерфейс
		<code>AuthenticationSuccessHandler</code> и обрабатывает событие успешной аутентификации пользователя;
	</li>
	<li><code>SpringExceptionHandler</code> осуществляет централизованную обработку исключений;</li>
	<li><code>SessionCartInterceptor</code> реализует интерфейс <code>HandlerInterceptorAdapter</code>
		и проверяет до обработки запроса контроллерами, существует ли в модели атрибут корзины покупателя;
		при отсутствии создатся новая корзина; такое решение позволяет централизовать создание корзины,
		в том числе для случая, когда браузер пользователя не принимает cookies и поэтому
		не поддерживает хранение параметров сессии;
	</li>
	<li><code>RestUserCheckInterceptor</code> реализует интерфейс <code>HandlerInterceptorAdapter</code>
		и используется для проверки прав пользователя при доступе к веб-службе;
	</li>
	<li>Классы в пакете <code>market.dto.assembler</code> расширяют класс <code>ResourceAssemblerSupport</code>
		Spring HATEOAS и объединяют средства создания DTO-объектов, возвращаемых клиенту.
	</li>
</ul>

<script type="text/javascript">
    $(document).ready(function () {
        $('#details').hide();
    });
</script>
